import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './mainpage.dart';

class WebResult extends StatefulWidget{
  List? searchResult;
  String? searchTitle;
  WebResult({Key? key, @required this.searchResult,
      @required this.searchTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebResult();
}

class _WebResult extends State<WebResult>{
  @override
  Widget build(BuildContext context){
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          child: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => MainPage()));
          },
        ),
        middle: Text('"${widget.searchTitle}" 검색결과'),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Expanded(
                child: ListView.builder(itemBuilder: (context, index){
                  return Card(
                    child: Row(
                      children: <Widget> [
                        Image.network(widget.searchResult![index]['thumbnail'],
                          width: 100, height: 100, fit: BoxFit.contain,),

                        Container(
                          width: MediaQuery.of(context).size.width - 150,
                          child: Column(
                            children: <Widget> [
                              Text(widget.searchResult![index]['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,),
                              Text('시간 : ${widget.searchResult![index]['play_time']}'),
                              Text('업로더 : ${widget.searchResult![index]['author']}')
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }, itemCount: widget.searchResult!.length,),
              )
            ],
          ),
        ),
      ));
  }
}