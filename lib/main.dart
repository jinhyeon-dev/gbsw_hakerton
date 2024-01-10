import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/screens/main_screen/main_screen.dart';
import 'package:gbsw_hakerton/widgets/splash_widget/splash_widget.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashWidget(),
        ),
        GetPage(
          name: '/main',
          page: () => MainScreen(),
        ),
      ],
      initialRoute: '/splash',
    );
  }
}
