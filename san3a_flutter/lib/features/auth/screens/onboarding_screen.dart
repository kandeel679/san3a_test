import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/utils/app_state.dart';
import '../../../core/l10n/app_localizations.dart';

/// Mirrors OnBoardingScreen.kt
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final t = AppLocalizations.of(context);

    final pages = [
      _OnboardingPage(
        icon: Icons.search,
        title: t.translate('onboardingTitle1'),
        description: t.translate('onboardingDesc1'),
      ),
      _OnboardingPage(
        icon: Icons.handshake,
        title: t.translate('onboardingTitle2'),
        description: t.translate('onboardingDesc2'),
      ),
      _OnboardingPage(
        icon: Icons.star,
        title: t.translate('onboardingTitle3'),
        description: t.translate('onboardingDesc3'),
      ),
    ];

    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: TextButton(
                onPressed: _onFinish,
                child: Text(
                  t.translate('skip'),
                  style: theme.textStyle.bodyMediumMedium.copyWith(color: theme.colors.brand.primary),
                ),
              ),
            ),
            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) {
                  final page = pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: theme.colors.brand.tertiary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(page.icon, size: 80, color: theme.colors.brand.primary),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          page.title,
                          style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.shade.primary),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.secondary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i ? theme.colors.brand.primary : theme.colors.shade.quaternary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppButton(
                text: _currentPage == pages.length - 1 ? t.translate('getStarted') : t.translate('next'),
                onPressed: () {
                  if (_currentPage < pages.length - 1) {
                    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  } else {
                    _onFinish();
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _onFinish() {
    AppStateProvider.of(context).setOnboardingDone();
    context.go('/register');
  }
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  const _OnboardingPage({required this.icon, required this.title, required this.description});
}
