import 'package:flutter/material.dart';

import '../../core/app_strings.dart';

class EmptyChat extends StatelessWidget {
  const EmptyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C091A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline,size: 64,color: Colors.deepPurple,),
            const SizedBox(height: 20),
            const Text(
              AppStrings.emptyChat,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
