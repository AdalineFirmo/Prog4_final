import 'package:flutter/material.dart';
import 'package:prog4_avaliacao3/core/app_routes.dart';
import 'package:prog4_avaliacao3/pages/detail_page/detail_page.dart';
import 'package:prog4_avaliacao3/pages/home_page/home_page.dart';

import '../pages/splash_page/splash_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.detail: (context) => const DetailPage(),
      },
    );
  }
}
