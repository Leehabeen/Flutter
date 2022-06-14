import 'package:cupertino_api_201/web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  TextEditingController? search;
  List? vclipData;
  List? imageData;

  @override
  void initState(){
    super.initState();
    search = TextEditingController();
    vclipData = new List.empty(growable: true);
    imageData = new List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Search Keyword'),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.square_arrow_right),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      child: Container(
        child: Center(
          child: Column(
            children: <Widget> [
              Row(
                children: <Widget> [
                  Expanded(child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: CupertinoTextField(
                        placeholder: "검색어를 입력하세요.",
                        controller: search,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  )),

                  Container(
                    width: MediaQuery.of(context).size.width - 300,
                    padding: EdgeInsets.only(right: 10),
                    child: CupertinoButton(
                      child: Text('검색'),
                      onPressed: () { getWebData(); },
                    ),
                  )
                ],
              ),

              CupertinoButton(
                child: Text('상일미디어고 이미지 검색 결과'),
                onPressed: () { getImageData(); },
              )
            ], mainAxisAlignment: MainAxisAlignment.center,
          )
        ),
      ),
    );
  }

  Future<String> getWebData() async {
    var url = "https://dapi.kakao.com/v2/search/vclip?size=30&&query=${search!.value.text}";
    var response = await http.get(Uri.parse(url),
    headers: {"Authorization" : "KakaoAK 0776339020aa94f06419a3a41c370b08"});

    setState(() {
      var dataConvert = json.decode(response.body);
      List result = dataConvert['documents'];
      vclipData!.addAll(result);
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (context)
          => WebResult(searchResult: vclipData, searchTitle: search!.value.text,)));
    });

    return response.body;
  }

  Future<String> getImageData() async{
    var url = 'https://dapi.kakao.com/v2/search/image?query=상일미디어고';
    var respons = await http.get(Uri.parse(url),
        headers: {"Authorization" : "KakaoAK 0776339020aa94f06419a3a41c370b08"});

    setState(() {
      var dataConverted = json.decode(respons.body);
      List result = dataConverted['documents'];
      imageData!.addAll(result);
    });

    print(respons.body);
    return respons.body;
  }
}