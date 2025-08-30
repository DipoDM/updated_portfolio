import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'game_painter.dart';

class GameLoop extends ChangeNotifier {
  // --- Timing ---------------------------------------------------------------
  Timer? _timer;
  final Stopwatch _clock = Stopwatch();
  static const double _step = 1.0 / 60.0; // 60 Hz sim
  static const int _maxSubSteps = 5; // spiral-of-death guard
  final Duration _tick = const Duration(milliseconds: 16);

  // --- Engine state ---------------------------------------------------------
  late final GamePainter _painter;
  bool _isRunning = false;
  bool _isPaused = true;
  bool _gameOver = false;

  // --- Gameplay state (normalized 0..1 coordinates) ------------------------
  double _playerX = 0.5;
  final List<Obstacle> _obstacles = <Obstacle>[];
  int _score = 0;

  // Tunables (per-second rates, stable across FPS)
  final Random _rng = Random();
  final double _spawnRatePerSec = 1.2; // ~1.2 obstacles per second
  final double _fallSpeed = 0.60; // 0.60 screen heights per second

  GameLoop() {
    _painter = GamePainter(this); // painter reads state from this
  }

  // Exposed read-only views
  GamePainter get painter => _painter;
  bool get isPaused => _isPaused;
  bool get isGameOver => _gameOver;
  bool get isRunning => _isRunning;
  int get score => _score;
  double get playerX => _playerX;
  List<Obstacle> get obstacles => _obstacles;

  // --- Lifecycle ------------------------------------------------------------
  /// Start or restart a run (always resets state).
  void start() {
    _stopTimer(); // ensure clean restart
    _resetState();

    _isRunning = true;
    _isPaused = false;
    _clock
      ..reset()
      ..start();
    _timer = Timer.periodic(_tick, (_) => _tickUpdate());
    notifyListeners();
  }

  void pause() {
    if (_isPaused) return;
    _isPaused = true;
    _stopTimer();
    notifyListeners();
  }

  void resume() {
    if (!_isPaused || _gameOver) return;
    _isPaused = false;
    _clock
      ..reset()
      ..start();
    _timer = Timer.periodic(_tick, (_) => _tickUpdate());
    notifyListeners();
  }

  void togglePause() => _isPaused ? resume() : pause();
  void pauseIfRunning() {
    if (_isRunning && !_isPaused) pause();
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _clock.stop();
    _isRunning = _timer != null; // stays false after stop
  }

  void _resetState() {
    _gameOver = false;
    _score = 0;
    _playerX = 0.5;
    _obstacles.clear();
  }

  // --- Input ----------------------------------------------------------------
  void movePlayer(int direction) {
    if (_gameOver || _isPaused) return;
    _playerX = (_playerX + direction * 0.05).clamp(0.05, 0.95);
    notifyListeners();
  }

  // --- Main loop ------------------------------------------------------------
  void _tickUpdate() {
    if (_isPaused || _gameOver) return;

    // real elapsed since last tick
    final double dt = _clock.elapsedMicroseconds / 1e6;
    _clock
      ..reset()
      ..start();

    // fixed timestep accumulator
    double acc = dt;
    int steps = 0;
    while (acc >= _step && steps < _maxSubSteps) {
      _stepOnce(_step);
      acc -= _step;
      steps++;
    }

    // paint once per timer tick
    notifyListeners();
  }

  void _stepOnce(double dt) {
    // Spawn: Poisson process => probability = rate * dt
    if (_rng.nextDouble() < _spawnRatePerSec * dt) {
      _obstacles.add(Obstacle(
        x: _rng.nextDouble(),
        y: 0.0,
        size: 0.03 + _rng.nextDouble() * 0.02,
      ));
    }

    // Move & cull obstacles
    for (final o in _obstacles) {
      o.y += _fallSpeed * dt;
    }
    _obstacles.removeWhere((o) => o.y > 1.1);

    // Collision check (simple circle vs point band near player)
    for (final o in _obstacles) {
      final dist = (o.x - _playerX).abs();
      final inBand = o.y > 0.85 && o.y < 0.95;
      if (inBand && dist < o.size + 0.03) {
        _gameOver = true;
        _stopTimer();
        break;
      }
    }

    if (!_gameOver) _score += 1;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}

class Obstacle {
  double x;
  double y;
  final double size;
  Obstacle({required this.x, required this.y, required this.size});
}
