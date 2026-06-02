import 'package:flutter/material.dart';
import 'package:llm_chatbot/presentation/splash/splash_screen.dart';

import '../presentation/provider/chat_provider.dart';
import 'package:provider/provider.dart';

import '../presentation/provider/img_provider.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [

       ChangeNotifierProvider(create: (context) => ChatProvider()),
       ChangeNotifierProvider(create: (context) => ImgProvider()),
     ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: SplashScreen(),
      ),
    );
  }
}
