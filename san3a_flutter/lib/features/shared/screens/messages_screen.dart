import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final chats = [
      _ChatUi(name: 'Ahmed Hassan', lastMsg: 'I can fix your plumbing issue', time: '2:30 PM', unread: 2),
      _ChatUi(name: 'Mohamed Ali', lastMsg: 'When should I come?', time: '1:15 PM', unread: 0),
      _ChatUi(name: 'Sara Ibrahim', lastMsg: 'Thank you for the great work!', time: 'Yesterday', unread: 0),
      _ChatUi(name: 'Khaled Omar', lastMsg: 'The price is 300 EGP', time: 'Yesterday', unread: 1),
    ];

    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      body: SafeArea(child: Column(children: [
        Container(color: theme.colors.background.card, padding: const EdgeInsets.all(16), child: Row(children: [
          Text('Messages', style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.shade.primary)),
        ])),
        Expanded(child: chats.isEmpty
          ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.chat_bubble_outline, size: 64, color: theme.colors.shade.tertiary),
              const SizedBox(height: 16),
              Text('No messages yet', style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.secondary)),
            ]))
          : ListView.separated(
              itemCount: chats.length, separatorBuilder: (_, __) => Divider(height: 1, color: theme.colors.stroke.primary),
              itemBuilder: (_, i) {
                final c = chats[i];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(radius: 24, backgroundColor: theme.colors.brand.tertiary, child: Text(c.name[0], style: theme.textStyle.titleSmall.copyWith(color: theme.colors.brand.primary))),
                  title: Text(c.name, style: theme.textStyle.bodyMediumSemibold.copyWith(color: theme.colors.shade.primary)),
                  subtitle: Text(c.lastMsg, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(c.time, style: theme.textStyle.labelMediumRegular.copyWith(color: theme.colors.shade.tertiary)),
                    if (c.unread > 0) ...[const SizedBox(height: 4), Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: theme.colors.brand.primary, shape: BoxShape.circle), child: Text('${c.unread}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))],
                  ]),
                );
              },
            )),
      ])),
    );
  }
}

class _ChatUi { final String name, lastMsg, time; final int unread; const _ChatUi({required this.name, required this.lastMsg, required this.time, required this.unread}); }
