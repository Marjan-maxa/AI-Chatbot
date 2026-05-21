import 'package:flutter/material.dart';
import 'package:llm_chatbot/presentation/widgets/empty_chat.dart';
import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../provider/chat_provider.dart';
import '../widgets/chat_feild.dart';
import '../widgets/message_bubble.dart';
import '../widgets/typing indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    return Scaffold(
      backgroundColor: const Color(0xFF0C091A),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Online',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.deepPurple,
        elevation: 5,
        title: Row(
          children: [
           Icon(Icons.smart_toy_outlined,size: 30,color: Colors.white.withOpacity(0.8),),
            const SizedBox(width: 10),
            Text(
              AppStrings.appName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          // Auto scroll to bottom when messages change or typing starts
          _scrollToBottom();

          return Column(
            children: [
              Expanded(
                child:chatProvider.messages.isEmpty && !chatProvider.isLoading? EmptyChat(): ListView.builder(
                  controller: _scrollController,
                  itemCount: chatProvider.messages.length + (chatProvider.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < chatProvider.messages.length) {
                      return MessageBubble(message: chatProvider.messages[index]);
                    } else {
                      return const TypingIndicator();
                    }
                  },
                ),
              ),
              if (chatProvider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    chatProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ChatFeild(
                isLoading: chatProvider.isLoading,
                onSubmitted: (text) {
                  chatProvider.sendMessage(text);
                },
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
