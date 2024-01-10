import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(
      const Duration(seconds: 5),
      () {
        Get.toNamed('/app');
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/icon.png', width: 120),
                const Text(
                  "낭비없는 음식",
                  style: TextStyle(
                    fontFamily: 'GmarketSansBold',
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "완벽한 소비의 시작",
                  style: TextStyle(
                    fontFamily: 'GmarketSansBold',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
