import 'package:flutter/material.dart';


import '../screens/chat_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeIn;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeIn = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubicEmphasized,
    );
    _animationController.forward();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  ChatScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C091A),
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: Image.asset(
                    'assets/img.png',
                  ),
                ),
              ),
              Text('AI Chat Bot',style: TextStyle(color: Colors.white,fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}