import 'package:flutter/material.dart';
import '../../../data/repositories/ai_repository.dart';
import '../../../data/sources/remote/api_client.dart';
import '../../../data/models/chat_message_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/l10n/app_localizations.dart';

class AiChatbotScreen extends StatefulWidget {
  const AiChatbotScreen({Key? key}) : super(key: key);

  @override
  State<AiChatbotScreen> createState() => _AiChatbotScreenState();
}

class _AiChatbotScreenState extends State<AiChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AiRepository _aiRepository = AiRepository(ApiClient());
  
  final List<ChatMessageModel> _messages = [];
  bool _isLoading = false;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final t = AppLocalizations.of(context);
      _messages.add(
        ChatMessageModel(
          chatId: 'ai_session',
          senderId: 'ai',
          receiverId: 'user',
          text: t.translate('aiGreeting'),
          timestamp: DateTime.now().millisecondsSinceEpoch,
        )
      );
      _initialized = true;
    }
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    
    setState(() {
      _messages.add(ChatMessageModel(
        chatId: 'ai_session',
        senderId: 'user',
        receiverId: 'ai',
        text: text,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ));
      _isLoading = true;
    });
    
    _scrollToBottom();

    // Call AI Repository
    final aiResponse = await _aiRepository.getChatbotResponse(text);

    setState(() {
      _isLoading = false;
      _messages.add(ChatMessageModel(
        chatId: 'ai_session',
        senderId: 'ai',
        receiverId: 'user',
        text: aiResponse,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ));
    });
    
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('aiAssistant'))),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg.senderId == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8, top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.primary : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          _buildMessageInput(t),
        ],
      ),
    );
  }

  Widget _buildMessageInput(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: t.translate('typeMessageDots'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
