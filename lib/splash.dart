import 'package:fashion_store/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:fashion_store/widgets/animation_line.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
     Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const Home(),
  ),
);
      // Navigation logic here
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/logo/Runway.svg',
              width: 100,
              height: 50,
            ),
          ),
          Gap(10),
         const AnimatedLine()
        ],
      ),
    );
  }
}
