import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/utilities/signcheack.dart';
import 'package:gbsw_hakerton/widgets/signin_widget.dart';
import 'package:gbsw_hakerton/widgets/signup_widget.dart';

class SignWidget extends StatelessWidget {
  const SignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/icon.png', width: 150),
              const Text(
                "푸드팁",
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'GmarketSansBold',
                  fontSize: 30,
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent, // 추가
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignSearch()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: 200,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Center(
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpWidget()),
                  );
                },
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Center(
                    child: Text(
                      "회원가입",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
