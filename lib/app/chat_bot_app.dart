import 'package:flutter/material.dart';
import 'package:llm_chatbot/presentation/splash/splash_screen.dart';

import '../presentation/provider/chat_provider.dart';
import 'package:provider/provider.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
