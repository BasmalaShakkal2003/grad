import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'splash_screen2.dart';
import 'group_members_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GroupMembersProvider(),
      child: const MaterialApp(
        home: SplashScreen1(), 
      ),
    ),
  );
}

//-------------------- splash screen 1---------------------------
class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/LOGO.png', width: 270, height: 250),
            Image.asset('assets/LOGO2.png', width: 320, height: 150),
            const SizedBox(height: 30),
            LoadingAnimationWidget.discreteCircle(
              color: const Color(0xFF0F5C8C),
              secondRingColor: const Color(0xFF09316E),
              thirdRingColor: const Color.fromARGB(255, 33, 114, 165),
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}













