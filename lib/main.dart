import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PublicFacilityList(),
    );
  }
}

class PublicFacilityList extends StatefulWidget {
  @override
  _PublicFacilityListState createState() => _PublicFacilityListState();
}

class _PublicFacilityListState extends State<PublicFacilityList> {
  int currentPage = 6; // 초기 페이지 번호 설정

  void fetchFacilities() async {
    String serviceKey = Uri.decodeComponent('2TfWGOJWFWcpo4FvXm3bfxWN9Wkum8q46w6IG%2Fa4f7foSPeB49puLIuh7IeX0jfkoslp0DhNy7%2BYHWJxGDa4mw%3D%3D');
    String url = 'http://apis.data.go.kr/4050000/sprtsfclts/getSprtsfclts?serviceKey=$serviceKey&pageNo=$currentPage&numOfRows=3';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('API Response for Page $currentPage: ${response.body}');  // 페이지 번호와 함께 JSON 응답을 콘솔에 출력
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Test App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentPage++;  // 버튼 클릭 시 페이지 번호 증가
                });
                fetchFacilities();  // 업데이트된 페이지 번호로 API 호출
              },
              child: Text('Load Next Page'),
            ),
          ],
        ),
      ),
    );
  }
}