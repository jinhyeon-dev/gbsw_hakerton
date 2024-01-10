import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/screens/shoppingcart_screen/shoppingcart_screen.dart';

class FridgeScreen extends StatelessWidget {
  const FridgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xffFE6470),
          title: const Text(
            "냉장고",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (content) => const ShoppingCartScreen()),
              );
            },
            tooltip: 'a',
            backgroundColor: const Color(0xffFE6470),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}
