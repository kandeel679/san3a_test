import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/utils/app_state.dart';
import '../core/theme/app_theme.dart';
// Auth screens
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/onboarding_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/account_setup_screen.dart';
// Shared screens
import '../features/shared/screens/messages_screen.dart';
import '../features/shared/screens/notification_screen.dart';
import '../features/shared/screens/more_screen.dart';
import '../features/shared/screens/my_requests_screen.dart';
// Client screens
import '../features/client/screens/home_screen.dart';
// Provider screens
import '../features/provider/screens/provider_home_screen.dart';

/// Shell route widget that provides the bottom navigation bar
class MainShell extends StatefulWidget {
  final Widget child;
  final bool isProvider;
  const MainShell({Key? key, required this.child, required this.isProvider}) : super(key: key);
  @override State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final prefix = widget.isProvider ? '/craftsman' : '/customer';

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colors.background.card,
          border: Border(top: BorderSide(color: theme.colors.stroke.primary)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home', isActive: _currentIndex == 0, theme: theme, onTap: () { setState(() => _currentIndex = 0); context.go(prefix); }),
                _NavItem(icon: Icons.list_alt_outlined, activeIcon: Icons.list_alt, label: widget.isProvider ? 'Jobs' : 'Requests', isActive: _currentIndex == 1, theme: theme, onTap: () { setState(() => _currentIndex = 1); context.go('$prefix/requests'); }),
                _NavItem(icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, label: 'Messages', isActive: _currentIndex == 2, theme: theme, onTap: () { setState(() => _currentIndex = 2); context.go('$prefix/messages'); }),
                _NavItem(icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: 'More', isActive: _currentIndex == 3, theme: theme, onTap: () { setState(() => _currentIndex = 3); context.go('$prefix/more'); }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon, activeIcon; final String label; final bool isActive; final San3aTheme theme; final VoidCallback onTap;
  const _NavItem({required this.icon, required this.activeIcon, required this.label, required this.isActive, required this.theme, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? theme.colors.brand.primary : theme.colors.shade.tertiary;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(isActive ? activeIcon : icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(label, style: theme.textStyle.labelMediumMedium.copyWith(color: color, fontSize: 11)),
        ]),
      ),
    );
  }
}

/// Complete app router mirroring all 3 Kotlin navigation graphs
class AppRouter {
  static GoRouter createRouter(AppState appState) {
    return GoRouter(
      initialLocation: '/splash',
      refreshListenable: appState,
      routes: [
        // --- Main Graph ---
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
        GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
        GoRoute(path: '/otp', builder: (_, state) => OtpScreen(phone: state.extra as String? ?? '')),
        GoRoute(path: '/account_setup', builder: (_, __) => const AccountSetupScreen()),
        GoRoute(path: '/notifications', builder: (_, __) => const NotificationScreen()),

        // --- Customer Graph (with bottom nav shell) ---
        ShellRoute(
          builder: (_, __, child) => MainShell(isProvider: false, child: child),
          routes: [
            GoRoute(path: '/customer', builder: (_, __) => const CustomerHomeScreen()),
            GoRoute(path: '/customer/requests', builder: (_, __) => const MyRequestsScreen()),
            GoRoute(path: '/customer/messages', builder: (_, __) => const MessagesScreen()),
            GoRoute(path: '/customer/more', builder: (_, __) => const MoreScreen()),
          ],
        ),

        // --- Craftsman Graph (with bottom nav shell) ---
        ShellRoute(
          builder: (_, __, child) => MainShell(isProvider: true, child: child),
          routes: [
            GoRoute(path: '/craftsman', builder: (_, __) => const CraftsmanHomeScreen()),
            GoRoute(path: '/craftsman/requests', builder: (_, __) => const MyRequestsScreen()),
            GoRoute(path: '/craftsman/messages', builder: (_, __) => const MessagesScreen()),
            GoRoute(path: '/craftsman/more', builder: (_, __) => const MoreScreen()),
          ],
        ),
      ],
    );
  }
}
