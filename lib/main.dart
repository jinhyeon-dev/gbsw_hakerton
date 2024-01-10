import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/screens/main_screen/main_screen.dart';
import 'package:gbsw_hakerton/screens/search_screen/search_screen.dart';
import 'package:gbsw_hakerton/screens/setting_screen/setting_screen.dart';
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
          name: '/app',
          page: () => MyAppScreen(),
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

class MyAppScreen extends StatefulWidget {
  const MyAppScreen({super.key});

  @override
  State<MyAppScreen> createState() => _MyAppScreenState();
}

class _MyAppScreenState extends State<MyAppScreen> {
int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    MainScreen(),
    SearchScreen(),
    
    SettingScreen(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: const Color(0xffFE6470),
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '홈',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen_outlined),
            label: '냉장고',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: '장바구니',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '설정',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}
