import 'package:flutter/material.dart';
import '/core/app_routes.dart';
import '/pages/detail_page/detail_page.dart';
import '/pages/home_page/home_page.dart';
import '../pages/splash_page/splash_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.detail: (context) => const DetailPage(),
      },
    );
  }
}
