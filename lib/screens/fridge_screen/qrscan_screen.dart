import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

String customDay(int days) {
  DateTime startDate = DateTime.now();
  DateTime endDate = startDate.add(Duration(days: days));
  Duration duration = endDate.difference(startDate);

  if (duration.inDays >= 365) {
    int years = duration.inDays ~/ 365;
    return '${years}year';
  } else if (duration.inDays >= 30) {
    int months = duration.inDays ~/ 30;
    return '${months}month';
  } else {
    return 'D-${duration.inDays}';
  }
}

int? convertToDays(String text) {
  RegExp regex = RegExp(r'(\d+)(년|개월|달|주|일)');
  Match? match = regex.firstMatch(text);

  if (match != null) {
    int value = int.parse(match.group(1)!);
    String unit = match.group(2)!;
    int days = 0;

    if (unit == '년') {
      days = value * 365; // 1년을 365일로 가정
    } else if (unit == '개월' || unit == '달') {
      days = value * 30; // 1개월을 30일로 가정
    } else if (unit == '주') {
      days = value * 7; // 1주를 7일로 가정
    } else if (unit == '일') {
      days = value;
    }

    return days;
  } else {
    return null;
  }
}

class QrscanScreen extends StatefulWidget {
  const QrscanScreen({super.key});

  @override
  State<QrscanScreen> createState() => _QrscanScreenState();
}

class _QrscanScreenState extends State<QrscanScreen> {
  String _barcodeResult = '';
  String _apiResponse = '';
  List<dynamic> _pogDayCountList = [];
  List<dynamic> _pogDayNameList = [];

  Future<void> _scanBarcode() async {
    String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      '취소',
      true,
      ScanMode.BARCODE,
    );

    setState(() {
      _barcodeResult = barcodeResult;
    });

    // Open API에 요청을 보내고 응답을 받아옴
    String apiUrl =
        'https://openapi.foodsafetykorea.go.kr/api/ec1f8519cadc4fb1bc65/C005/json/1/1000/BAR_CD=$_barcodeResult';
    print(apiUrl);
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // 응답이 성공적으로 받아진 경우
      setState(() {
        _apiResponse = response.body;
        // POG_DAYCNT 값을 추출하여 _pogDayCountList에 저장
        final decodedResponse = json.decode(_apiResponse);
        print(decodedResponse['C005']['RESULT']['MSG']);
        if (decodedResponse['C005']['RESULT']['MSG'] != '해당하는 데이터가 없습니다.') {
          var rows = decodedResponse['C005']['row'];
          _pogDayCountList = rows
              .map((row) => row['POG_DAYCNT'])
              .where((pogDayCnt) =>
                  pogDayCnt != null && pogDayCnt.trim().isNotEmpty)
              .toList();
          _pogDayNameList = rows
              .map((row) => row['PRDLST_NM'])
              .where((pogDayCnt) =>
                  pogDayCnt != null && pogDayCnt.trim().isNotEmpty)
              .toList();
        } else {
          print("상품이 검색 안됨");
          _pogDayCountList = [];
          _pogDayNameList = [];
        }
      });
    } else {
      // 응답이 실패한 경우
      setState(() {
        _apiResponse = 'API 요청에 실패했습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String contentName = '';
    contentName =
        _pogDayNameList.isNotEmpty ? _pogDayNameList[0] : '이름을 불러오지 못했습니다.';

    String contentDay = '';
    int? temp =
        convertToDays(_pogDayCountList.isNotEmpty ? _pogDayCountList[0] : '');
    contentDay = temp != null ? customDay(temp!) : '제조일자를 불러오지 못했습니다.';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFE6470),
        title: const Text(
          "바코드 스캔",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "바코드 스캔하기",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanBarcode,
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 30),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('바코드 스캔'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Text(
                    contentName,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    contentDay,
                    style: TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DataSnapshot data = await FirebaseDatabase.instance
                          .ref()
                          .child('list')
                          .get();

                      // 이름과 제조일자가 불러와지지 않은 경우에는 추가하지 않음
                      if (_pogDayNameList.isNotEmpty &&
                          _pogDayCountList.isNotEmpty) {
                        String contentName = _pogDayNameList[0];
                        int? temp = convertToDays(_pogDayCountList[0]);
                        String contentDay = temp != null ? customDay(temp) : '';

                        FirebaseDatabase.instance.ref().child('list').update({
                          '${data.children.length}': {
                            'name': contentName,
                            'date': contentDay,
                          }
                        });

                        if (context.mounted) {
                          FocusScope.of(context).unfocus();
                        }

                        Navigator.pop(context);
                      } else {
                        // 이름 또는 제조일자가 불러와지지 않은 경우, 알림 등을 추가할 수 있습니다.
                        print('데이터가 없어서 추가되지 않았습니다.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 30),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('냉장고에 넣기'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
