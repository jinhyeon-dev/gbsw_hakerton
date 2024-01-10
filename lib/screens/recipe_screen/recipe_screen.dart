import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _apiResponse = '';
  List<dynamic> _pog = [];

  Future<void> _fetchData(String ingredient) async {
    final url =
        'https://openapi.foodsafetykorea.go.kr/api/ec1f8519cadc4fb1bc65/COOKRCP01/json/0/1000/RCP_PARTS_DTLS=$ingredient';
    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _apiResponse = response.body;
        final decodedResponse = json.decode(_apiResponse);
        if (decodedResponse['COOKRCP01']['RESULT']['MSG'] !=
            '해당하는 데이터가 없습니다.') {
          var rows = decodedResponse['COOKRCP01']['row'];
          _pog = rows
              .map((row) =>
                  '음식 이름 : ' +
                  row['RCP_NM'] +
                  '\n' +
                  row['RCP_PARTS_DTLS'] +
                  '\n')
              .where((pogDayCnt) =>
                  pogDayCnt != null && pogDayCnt.trim().isNotEmpty)
              .toList();
        } else {
          print("레시피 검색 안됨");
          _pog = ['레시피가 검색되지 않습니다.'];
        }
      });
    } else {
      // Handle error case
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffFE6470),
            title: const Text(
              "레시피",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: TextField(
                                  cursorColor: Color(0xffFE6470),
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '재료명을 입력하세요',
                                  ),
                                  textInputAction: TextInputAction.go,
                                  onSubmitted: (value) async {
                                    String ingredient =
                                        _textEditingController.text;
                                    _fetchData(ingredient);
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: _pog.map((pogDayCount) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Card(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      pogDayCount,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
