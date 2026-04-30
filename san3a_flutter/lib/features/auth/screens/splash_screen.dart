import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_state.dart';
import '../../../core/l10n/app_localizations.dart';

/// Mirrors SplashScreen.kt
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final appState = AppStateProvider.of(context);
      if (appState.isOnboardingDone) {
        if (appState.savedPhone != null) {
          // Returning user — route based on role
          final step = appState.currentSetupStep;
          if (step == 'COMPLETED') {
            if (appState.isProvider) {
              context.go('/craftsman');
            } else {
              context.go('/customer');
            }
          } else {
            context.go('/account_setup');
          }
        } else {
          context.go('/register');
        }
      } else {
        context.go('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.colors.brand.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.handyman, size: 80, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                t.translate('san3aArabic'),
                style: theme.textStyle.displayXLarge.copyWith(color: Colors.white, fontSize: 48),
              ),
              const SizedBox(height: 8),
              Text(
                t.translate('appName'),
                style: theme.textStyle.titleLarge.copyWith(color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
