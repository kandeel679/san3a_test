import 'package:flutter/material.dart';
import '../../../core/l10n/app_localizations.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  const ChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('chat'))),
      body: Column(
        children: [
          Expanded(
            child: Center(child: Text('Chat messages for $chatId')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: t.translate('typeMessage')),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send), onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}
