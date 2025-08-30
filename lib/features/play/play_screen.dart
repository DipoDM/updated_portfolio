import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/widgets/responsive.dart';
import 'engine/game_loop.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late final GameLoop _gameLoop;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _gameLoop = GameLoop();
  }

  @override
  void dispose() {
    _gameLoop.dispose();
    super.dispose();
  }

  void _startOrRestart() {
    setState(() => _started = true);
    _gameLoop.start(); // assume start() handles restart semantics
  }

  void _togglePause() {
    if (!_started) return;
    _gameLoop.togglePause();
    setState(() {}); // update button label
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paused = _gameLoop.isPaused;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.getMaxWidth(context)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Text(
                    '🎮 Easter Egg Game',
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'A simple dodger game! Use arrow keys or tap to move.',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Game area
                  Expanded(
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: _started ? GameWidget(gameLoop: _gameLoop) : _StartScreen(onStart: _startOrRestart),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Controls
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton(
                        onPressed: _startOrRestart,
                        child: Text(_started ? 'Restart' : 'Start Game'),
                      ),
                      OutlinedButton(
                        onPressed: _started ? _togglePause : null,
                        child: Text(paused ? 'Resume' : 'Pause'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StartScreen extends StatelessWidget {
  const _StartScreen({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.games, size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Ready to Play?',
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Dodge the falling obstacles and survive as long as you can!',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Controls:',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '← → arrow keys or tap to move · Space to pause',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start'),
          ),
        ],
      ),
    );
  }
}

class GameWidget extends StatefulWidget {
  const GameWidget({super.key, required this.gameLoop});
  final GameLoop gameLoop;

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> with WidgetsBindingObserver {
  final FocusNode _focusNode = FocusNode();

  // Keyboard mapping using Shortcuts/Actions (better than raw key events on web)
  Map<LogicalKeySet, Intent> get _shortcuts => {
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): _MoveIntent(-1),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): _MoveIntent(1),
        LogicalKeySet(LogicalKeyboardKey.space): _PauseIntent(),
      };

  Map<Type, Action<Intent>> get _actions => {
        _MoveIntent: CallbackAction<_MoveIntent>(
          onInvoke: (i) {
            widget.gameLoop.movePlayer(i.direction);
            return null;
          },
        ),
        _PauseIntent: CallbackAction<_PauseIntent>(
          onInvoke: (_) {
            widget.gameLoop.togglePause();
            // No setState here; PlayScreen owns the button label state.
            return null;
          },
        ),
      };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Autofocus once the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Be polite with CPU/battery on web and mobile
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      widget.gameLoop.pauseIfRunning();
      // widget.gameLoop.togglePause(); // <-- replace pauseIfRunning()
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder rebuilds only the paint region when GameLoop notifies.
    // in GameWidget.build(...)
    return LayoutBuilder(
      builder: (context, constraints) {
        return FocusableActionDetector(
          autofocus: true,
          focusNode: _focusNode,
          shortcuts: _shortcuts,
          actions: _actions,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) {
                final dx = details.localPosition.dx;
                final width = constraints.maxWidth;
                widget.gameLoop.movePlayer(dx < width / 2 ? -1 : 1);
                // keep keyboard responsive after clicks
                _focusNode.requestFocus();
              },
              child: RepaintBoundary(
                child: SizedBox.expand(
                  // ensure the canvas always has size
                  child: CustomPaint(
                    painter: widget.gameLoop.painter, // same instance, now “repaint”-wired
                    isComplex: true,
                    willChange: true,
                  ),
                ),
              ),
            ),
          ),
          onFocusChange: (hasFocus) {
            if (!hasFocus) _focusNode.requestFocus();
          },
        );
      },
    );
  }
}

// ---------- Intents ----------
class _MoveIntent extends Intent {
  const _MoveIntent(this.direction);
  final int direction; // -1 left, +1 right
}

class _PauseIntent extends Intent {
  const _PauseIntent();
}
