import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/l10n/app_localizations.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final t = AppLocalizations.of(context);
    final notifications = [
      _NotifUi(title: 'New offer received', caption: 'Ahmed sent you an offer for your plumbing request', time: '2 min ago', isRead: false),
      _NotifUi(title: 'Request accepted', caption: 'Your request for electrical work has been accepted', time: '1 hour ago', isRead: false),
      _NotifUi(title: 'New message', caption: 'Mohamed Ali sent you a message', time: '3 hours ago', isRead: true),
      _NotifUi(title: 'Job completed', caption: 'Your painting job has been marked as completed', time: 'Yesterday', isRead: true),
    ];

    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      appBar: AppBar(
        backgroundColor: theme.colors.background.card, elevation: 0,
        title: Text(t.translate('notifications'), style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.primary)),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: theme.colors.shade.primary), onPressed: () => Navigator.pop(context)),
        actions: [TextButton(onPressed: () {}, child: Text(t.translate('markAllRead'), style: theme.textStyle.bodySmallMedium.copyWith(color: theme.colors.brand.primary)))],
      ),
      body: ListView.separated(
        itemCount: notifications.length, separatorBuilder: (_, __) => Divider(height: 1, color: theme.colors.stroke.primary),
        itemBuilder: (_, i) {
          final n = notifications[i];
          return Container(
            color: n.isRead ? null : theme.colors.brand.tertiary.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: theme.colors.brand.tertiary, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.notifications, color: theme.colors.brand.primary, size: 20)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(n.title, style: theme.textStyle.bodyMediumSemibold.copyWith(color: theme.colors.shade.primary)),
                const SizedBox(height: 4),
                Text(n.caption, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary)),
                const SizedBox(height: 4),
                Text(n.time, style: theme.textStyle.labelMediumRegular.copyWith(color: theme.colors.shade.tertiary)),
              ])),
            ]),
          );
        },
      ),
    );
  }
}

class _NotifUi { final String title, caption, time; final bool isRead; const _NotifUi({required this.title, required this.caption, required this.time, required this.isRead}); }
