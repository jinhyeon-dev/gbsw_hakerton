import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/screens/fridge_screen/qrscan_screen.dart';

class FridgeScreen extends StatelessWidget {
  const FridgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
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
        body: Row(
          children: [
            StreamBuilder(
              stream: FirebaseDatabase.instance.ref().child('list').onValue,
              builder: (context, snapshot) {
                List data = (snapshot.data?.snapshot.value ?? []) as List;
                print(data); // log

                data = data.reversed.toList();
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index < data.length) {
                        var itemName = data[index]?['name'] ?? "이름 없음";
                        var itemDate = data[index]?['date'] ?? "삭제된 메세지입니다.";

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                              width: 340,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.green.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(25),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          itemDate,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(itemName, style: TextStyle( 
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemCount: data.length,
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QrscanScreen()),
              );
            },
            tooltip: 'camera',
            child:
                Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}
