/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'responsive.dart';
import 'chip.dart';
import '../theme/app_theme.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;

  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => context.go('/'),
          child: const Text(
            'Oladipo Danmusa',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeModeProvider) == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              final currentMode = ref.read(themeModeProvider);
              ref.read(themeModeProvider.notifier).state = currentMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (Responsive.isDesktop(context)) _buildDesktopNavigation(context, currentLocation),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: Responsive.isMobile(context) ? _buildMobileNavigation(context, currentLocation) : null,
    );
  }

  Widget _buildDesktopNavigation(BuildContext context, String currentLocation) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildNavItems(context, currentLocation),
      ),
    );
  }

  Widget _buildMobileNavigation(BuildContext context, String currentLocation) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _getCurrentIndex(currentLocation),
      onTap: (index) => _navigateToIndex(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
        BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'Experience'),
        BottomNavigationBarItem(icon: Icon(Icons.auto_fix_high), label: 'Skills'),
        BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact'),
      ],
    );
  }

  List<Widget> _buildNavItems(BuildContext context, String currentLocation) {
    final items = [
      ('Home', '/', Icons.home),
      ('Projects', '/projects', Icons.work),
      ('Experience', '/experience', Icons.timeline),
      ('Skills', '/skills', Icons.psychology),
      ('About', '/about', Icons.person),
      ('Contact', '/contact', Icons.contact_mail),
      ('Resume', '/resume', Icons.description),
    ];

    return items.map((item) {
      final isActive = currentLocation.startsWith(item.$2);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: AppChip(
          label: item.$1,
          icon: item.$3,
          isSelected: isActive,
          onTap: () => context.go(item.$2),
        ),
      );
    }).toList();
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/projects')) return 1;
    if (location.startsWith('/experience')) return 2;
    if (location.startsWith('/skills')) return 3;
    if (location.startsWith('/contact')) return 4;
    return 0;
  }

  void _navigateToIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/projects');
        break;
      case 2:
        context.go('/experience');
        break;
      case 3:
        context.go('/skills');
        break;
      case 4:
        context.go('/contact');
        break;
    }
  }
}
*/

// lib/core/widgets/app_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'responsive.dart';
import 'chip.dart';
import '../theme/app_theme.dart';

class AppScaffold extends ConsumerStatefulWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  Listenable? _routerListenable; // GoRouter.routerDelegate is a ChangeNotifier

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final listenable = GoRouter.of(context).routerDelegate;
    if (_routerListenable != listenable) {
      _routerListenable?.removeListener(_onRoute);
      _routerListenable = listenable..addListener(_onRoute);
    }
  }

  void _onRoute() {
    if (mounted) setState(() {}); // refresh active nav styles on route change
  }

  @override
  void dispose() {
    _routerListenable?.removeListener(_onRoute);
    super.dispose();
  }

  // Current path, robust across go_router versions
  String _currentPath(BuildContext context) {
    final info = GoRouter.of(context).routeInformationProvider.value;
    // Flutter recent SDKs expose `uri`; use its path.
    return info.uri.path; // e.g. '/', '/projects', '/skills/advanced'
  }

  @override
  Widget build(BuildContext context) {
    final path = _currentPath(context);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => context.go('/'),
          child: const Text('Oladipo Danmusa', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        actions: [
          Responsive.isMobile(context)
              ? const SizedBox.shrink()
              : IconButton(
                  icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    final current = ref.read(themeModeProvider);
                    ref.read(themeModeProvider.notifier).state = current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                  },
                ),
        ],
      ),
      body: Column(
        children: [
          if (Responsive.isDesktop(context) || Responsive.isTablet(context)) _DesktopNav(currentPath: path),
          Expanded(child: widget.child),
        ],
      ),
      drawer: Responsive.isMobile(context) ? _MobileDrawer(currentPath: path) : null,
    );
  }
}

/*class _DesktopNav extends StatelessWidget {
  const _DesktopNav({required this.currentPath});
  final String currentPath;

  static final _items = <({String label, String path, IconData icon})>[
    (label: 'Home', path: '/', icon: Icons.home),
    (label: 'Projects', path: '/projects', icon: Icons.work),
    (label: 'Experience', path: '/experience', icon: Icons.timeline),
    (label: 'Skills', path: '/skills', icon: Icons.psychology),
    (label: 'About', path: '/about', icon: Icons.person),
    (label: 'Contact', path: '/contact', icon: Icons.contact_mail),
    (label: 'Resume', path: '/resume', icon: Icons.description),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _items.map((item) {
          final isActive = _match(currentPath, item.path);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AppChip(
              label: item.label,
              icon: item.icon,
              isSelected: isActive,
              onTap: () => context.go(item.path),
            ),
          );
        }).toList(),
      ),
    );
  }
}*/

class _DesktopNav extends StatelessWidget {
  const _DesktopNav({required this.currentPath});
  final String currentPath;

  static final _items = <({String label, String path, IconData icon})>[
    (label: 'Home', path: '/', icon: Icons.home),
    (label: 'Projects', path: '/projects', icon: Icons.work),
    (label: 'Experience', path: '/experience', icon: Icons.timeline),
    (label: 'Skills', path: '/skills', icon: Icons.psychology),
    (label: 'About', path: '/about', icon: Icons.person),
    (label: 'Contact', path: '/contact', icon: Icons.contact_mail),
    (label: 'Resume', path: '/resume', icon: Icons.description),
  ];

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final s = t.colorScheme;

    return Material(
      color: s.surface.withOpacity(0.85),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: s.surface.withOpacity(0.85),
          border: Border(bottom: BorderSide(color: s.outlineVariant, width: 1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Theme(
          data: t.copyWith(
            chipTheme: t.chipTheme.copyWith(
              shape: const StadiumBorder(),
              side: BorderSide(color: s.outlineVariant),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              backgroundColor: s.surfaceContainerHighest.withOpacity(0.65),
              selectedColor: s.primaryContainer,
              disabledColor: s.surfaceContainerHighest.withOpacity(0.30),
              labelStyle: t.textTheme.labelLarge?.copyWith(color: s.onSurface),
              secondaryLabelStyle: t.textTheme.labelLarge?.copyWith(color: s.onPrimaryContainer),
              brightness: t.brightness,
            ),
            iconTheme: t.iconTheme.copyWith(color: s.onSurfaceVariant),
          ),
          child: Center(
            child: ConstrainedBox(
              // Optional rail cap so lines don't get too long on ultrawide
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8, // space between chips in a row
                runSpacing: 8, // space between rows when wrapping
                children: _items.map((item) {
                  final isActive = _match(currentPath, item.path);
                  return AppChip(
                    label: item.label,
                    icon: item.icon,
                    isSelected: isActive,
                    onTap: () => context.go(item.path),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer({required this.currentPath});
  final String currentPath;

  static const _navigationItems = [
    (label: 'Home', path: '/', icon: Icons.home),
    (label: 'Projects', path: '/projects', icon: Icons.work),
    (label: 'Experience', path: '/experience', icon: Icons.timeline),
    (label: 'Skills', path: '/skills', icon: Icons.psychology),
    (label: 'About', path: '/about', icon: Icons.person),
    (label: 'Contact', path: '/contact', icon: Icons.contact_mail),
    (label: 'Resume', path: '/resume', icon: Icons.description),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      child: Column(
        children: [
          // Modern drawer header with gradient
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.secondary,
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      child: Text(
                        'OD',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Oladipo Danmusa',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Flutter & iOS Developer',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Navigation items
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _navigationItems.length,
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                indent: 56,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                final item = _navigationItems[index];
                final isActive = _match(currentPath, item.path);

                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  ),
                  title: Text(
                    item.label,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isActive ? colorScheme.primary : colorScheme.onSurface,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  selected: isActive,
                  selectedTileColor: colorScheme.primaryContainer.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  onTap: () {
                    Navigator.of(context).pop(); // Close drawer
                    context.go(item.path);
                  },
                );
              },
            ),
          ),

          // Footer with theme toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Consumer(
              builder: (context, ref, _) {
                final themeMode = ref.watch(themeModeProvider);
                return ListTile(
                  leading: Icon(
                    themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  title: Text(
                    themeMode == ThemeMode.dark ? 'Light Mode' : 'Dark Mode',
                    style: theme.textTheme.bodyLarge,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    final current = ref.read(themeModeProvider);
                    ref.read(themeModeProvider.notifier).state = current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Matching rules:
// - '/' is active only for exact home
// - '/foo' is active for '/foo' and '/foo/...'
bool _match(String currentPath, String base) {
  if (base == '/') return currentPath == '/';
  return currentPath == base || currentPath.startsWith('$base/');
}
