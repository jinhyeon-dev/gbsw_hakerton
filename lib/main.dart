import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gbsw_hakerton/utilities/signcheack.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/screens/fridge_screen/fridge_screen.dart';
import 'package:gbsw_hakerton/screens/main_screen/main_screen.dart';
import 'package:gbsw_hakerton/screens/search_screen/search_screen.dart';
import 'package:gbsw_hakerton/screens/setting_screen/setting_screen.dart';
import 'package:gbsw_hakerton/screens/shoppingcart_screen/shoppingcart_screen.dart';
import 'package:gbsw_hakerton/widgets/sign_widget.dart';
import 'package:gbsw_hakerton/widgets/signin_widget.dart';
import 'package:gbsw_hakerton/widgets/signup_widget.dart';
import 'package:gbsw_hakerton/widgets/splash_widget.dart';
import 'package:get/route_manager.dart';

void main() async {
  runApp(const MyApp());
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instanceFor(app: app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashWidget(),
        ),
        GetPage(
          name: '/sign',
          page: () => const SignWidget(),
        ),
        GetPage(
          name: '/sign',
          page: () => const SignWidget(),
        ),
        GetPage(
          name: '/signin',
          page: () => SignInWidget(),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignUpWidget(),
        ),
        GetPage(
          name: '/app',
          page: () => const MyAppScreen(),
        ),
        GetPage(
          name: '/main',
          page: () => const MainScreen(),
        ),
        GetPage(
          name: '/shop',
          page: () => const ShoppingCartScreen(),
        ),
        GetPage(
          name: '/fredge',
          page: () => const FridgeScreen(),
        ),
        GetPage(
          name: '/search',
          page: () => const SearchScreen(),
        ),
        GetPage(
          name: '/setting',
          page: () => const SettingScreen(),
        ),
        GetPage(
          name: '/signcheack',
          page: () => const SignCheack(),
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
    const MainScreen(),
    const SearchScreen(),
    const FridgeScreen(),
    const ShoppingCartScreen(),
    const SettingScreen(),
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
            icon: Icon(Icons.cookie_outlined),
            label: '레시피',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}
