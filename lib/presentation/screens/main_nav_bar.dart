import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'img_gen_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [ChatScreen(), ImgGenScreen()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 65.0, // বারের উচ্চতা

        backgroundColor: Colors.transparent,

        color: const Color(0xFF1E1E2C),

        buttonBackgroundColor: Colors.deepPurpleAccent,

        animationCurve:
            Curves.easeInOutCubicEmphasized, // লিকুইড বা স্প্রিং অ্যানিমেশন
        animationDuration: const Duration(milliseconds: 600), // স্পিড

        items: <Widget>[
          Icon(
            Icons.chat_bubble_rounded,
            size: 30,

            color: _currentIndex == 0 ? Colors.white : Colors.grey.shade500,
          ),
          Icon(
            Icons.image_rounded,
            size: 30,
            color: _currentIndex == 1 ? Colors.white : Colors.grey.shade500,
          ),
        ],

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
