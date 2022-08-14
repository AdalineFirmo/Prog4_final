import 'dart:async';
import 'package:flutter/material.dart';
import '../home_page/home_page.dart';
import 'components/animations.dart';
import 'components/fade_rout_builder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _animationA = false;
  bool _animationB = false;
  bool _animationC = false;
  bool _animationD = false;
  bool _animationE = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _animationA = true;
      });
    });
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _animationB = true;
      });
    });
    Timer(const Duration(milliseconds: 1300), () {
      setState(() {
        _animationC = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        _animationE = true;
      });
    });
    Timer(const Duration(milliseconds: 3400), () {
      setState(() {
        _animationD = true;
      });
    });
    Timer(const Duration(milliseconds: 3850), () {
      setState(() {
        Navigator.of(context)
            .pushReplacement(ThisIsFadeRoute(route: const HomePage()));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AmimationFeature(
            animationA: _animationA,
            animationB: _animationB,
            animationC: _animationC,
            animationD: _animationD,
            animationE: _animationE,
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}
