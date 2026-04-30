import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/app_state.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final appState = AppStateProvider.of(context);

    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      body: SafeArea(child: ListView(children: [
        Container(color: theme.colors.background.card, padding: const EdgeInsets.all(16), child: Row(children: [
          CircleAvatar(radius: 28, backgroundColor: theme.colors.brand.tertiary, child: Text((appState.fullName ?? 'U')[0], style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.brand.primary))),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(appState.fullName ?? 'User', style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.primary)),
            Text(appState.savedPhone ?? '', style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary)),
          ])),
          Icon(Icons.edit_outlined, color: theme.colors.shade.secondary),
        ])),
        const SizedBox(height: 16),
        _Section(theme: theme, title: 'Account', items: [
          _MenuItem(icon: Icons.person_outline, title: 'Profile Settings', onTap: () {}),
          if (!appState.isProvider) _MenuItem(icon: Icons.handyman, title: 'Become a Craftsman', onTap: () => context.go('/account_setup')),
          if (appState.isProvider) _MenuItem(icon: Icons.build_outlined, title: 'My Services', onTap: () {}),
          if (appState.isProvider) _MenuItem(icon: Icons.location_on_outlined, title: 'My Location', onTap: () {}),
        ]),
        const SizedBox(height: 16),
        _Section(theme: theme, title: 'Preferences', items: [
          _MenuItem(icon: Icons.language, title: 'Language', trailing: 'English', onTap: () {}),
          _MenuSwitch(icon: Icons.dark_mode_outlined, title: 'Dark Mode', value: appState.isDark, onChanged: (v) => appState.toggleDarkMode()),
        ]),
        const SizedBox(height: 16),
        _Section(theme: theme, title: 'Support', items: [
          _MenuItem(icon: Icons.help_outline, title: 'Help Center', onTap: () {}),
          _MenuItem(icon: Icons.info_outline, title: 'About San3a', onTap: () {}),
        ]),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: GestureDetector(
          onTap: () { appState.logout(); context.go('/register'); },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: theme.colors.additional.secondary.error, borderRadius: BorderRadius.circular(theme.radius.extraLarge)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.logout, color: theme.colors.additional.primary.error),
              const SizedBox(width: 8),
              Text('Log Out', style: theme.textStyle.bodyLargeMedium.copyWith(color: theme.colors.additional.primary.error)),
            ]),
          ),
        )),
        const SizedBox(height: 32),
      ])),
    );
  }
}

class _Section extends StatelessWidget {
  final San3aTheme theme; final String title; final List<Widget> items;
  const _Section({required this.theme, required this.title, required this.items});
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: theme.textStyle.bodySmallSemibold.copyWith(color: theme.colors.shade.tertiary)),
    const SizedBox(height: 8),
    Container(decoration: BoxDecoration(color: theme.colors.background.card, borderRadius: BorderRadius.circular(theme.radius.extraLarge)), child: Column(children: items)),
  ]));
}

class _MenuItem extends StatelessWidget {
  final IconData icon; final String title; final String? trailing; final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.title, this.trailing, required this.onTap});
  @override Widget build(BuildContext context) { final theme = San3aTheme.of(context); return ListTile(leading: Icon(icon, color: theme.colors.shade.secondary), title: Text(title, style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.primary)), trailing: trailing != null ? Text(trailing!, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.tertiary)) : Icon(Icons.arrow_forward_ios, size: 16, color: theme.colors.shade.tertiary), onTap: onTap); }
}

class _MenuSwitch extends StatelessWidget {
  final IconData icon; final String title; final bool value; final ValueChanged<bool> onChanged;
  const _MenuSwitch({required this.icon, required this.title, required this.value, required this.onChanged});
  @override Widget build(BuildContext context) { final theme = San3aTheme.of(context); return ListTile(leading: Icon(icon, color: theme.colors.shade.secondary), title: Text(title, style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.primary)), trailing: Switch(value: value, onChanged: onChanged, activeColor: theme.colors.brand.primary)); }
}
