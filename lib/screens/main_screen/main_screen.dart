import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/utilities/highlightedtext.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String user = '진현';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset('assets/icons/user.png'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 120,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "안녕하세요",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        HighLightedText(
                                          "user",
                                          color: Color(0xffFE6470),
                                          fontSize: 24,
                                        ),
                                        Text(
                                          "님!",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
