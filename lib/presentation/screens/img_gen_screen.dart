import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../provider/img_provider.dart';
import '../widgets/chat_feild.dart';
import '../widgets/empty_img_gen.dart';
import '../widgets/image_bubble.dart';
import '../widgets/typing indicator.dart';

class ImgGenScreen extends StatefulWidget {
  const ImgGenScreen({super.key});

  @override
  State<ImgGenScreen> createState() => _ImgGenScreenState();
}

class _ImgGenScreenState extends State<ImgGenScreen> {
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
            Icon(
              Icons.image_outlined,
              size: 30,
              color: Colors.white.withOpacity(0.8),
            ),
            const SizedBox(width: 10),
            const Text(
              "AI Image Gen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<ImgProvider>(
        builder: (context, imgProvider, child) {
          // Auto scroll to bottom when messages change or typing starts
          _scrollToBottom();

          return Column(
            children: [
              Expanded(
                child: imgProvider.messages.isEmpty && !imgProvider.isLoading
                    ? const EmptyImageGen()
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: imgProvider.messages.length +
                            (imgProvider.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < imgProvider.messages.length) {
                            return ImageBubble(
                                message: imgProvider.messages[index]);
                          } else {
                            return const TypingIndicator();
                          }
                        },
                      ),
              ),
              if (imgProvider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    imgProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ChatFeild(
                hinttext: AppStrings.imageGenInputHint,
                isLoading: imgProvider.isLoading,
                onSubmitted: (text) {
                  imgProvider.generateImage(text);
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
