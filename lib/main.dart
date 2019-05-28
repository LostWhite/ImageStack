// Step 7 (Final): Change the app's theme
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'models/index.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: DeliveryPage(),
    );
  }
}

/// 气球快递页面
class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  List<ImageModel> addStr = [];
  List<ImageModel> str = [
    new ImageModel.fromJson({
      'id': "1",
      'url': 'img-00a01823427273775a1198a1015a8f35.jpg',
      'like_count': "0"
    })
  ];
  final _baseUrl = 'http://api.baiyuesong.com/site/';
  final _baseImageUrl = 'http://images.baiyuesong.com/app/';

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  var page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery"),
      ),
      backgroundColor: Color(0xFFEEEEEE),
      body: Center(
          child: new EasyRefresh(
        firstRefresh: true,
        autoLoad: true,
        key: _easyRefreshKey,
        refreshHeader: DeliveryHeader(
          key: _headerKey,
        ),
        refreshFooter: PhoenixFooter(
          key: _footerKey,
        ),
        child: new ListView.builder(
            //ListView的Item
            itemCount: str.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                  child: Card(
                child: new Center(
                  child: new Image(
                      image: NetworkImage(this._baseImageUrl + str[index].url),
                      fit: BoxFit.fitWidth),
                ),
              ));
            }),
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 3), () {
            if (!mounted) return;
            setState(() {
              str.clear();
              page = 0;
              _getImagesList(page);
            });
          });
        },
        loadMore: () async {
          await new Future.delayed(const Duration(seconds: 1), () {
            page++;
            _getImagesList(page);
          });
        },
      )),
      persistentFooterButtons: <Widget>[
        FlatButton(
            onPressed: () {
              _easyRefreshKey.currentState.callRefresh();
            },
            child: Text("refresh", style: TextStyle(color: Colors.black))),
        FlatButton(
            onPressed: () {
              _easyRefreshKey.currentState.callLoadMore();
            },
            child: Text("loadMore", style: TextStyle(color: Colors.black)))
      ], // This trailing comma makes auto-formatting nicer for build methods.,
    );
  }

  _getImagesList(page) async {
    Dio dio = new Dio();
    Response response;
    response = await dio.get(_baseUrl + "image?page=" + page.toString());

    var result = [];

    if (response.statusCode == 200) {
      result = json.decode(response.data);

      for (var x in result) {
        setState(() {
          str.add(ImageModel.fromJson(x));
        });
      }
      print(str);
      return result;
    } else {
      result = [
        'Error getting IP address:\nHttp status ${response.statusCode}'
      ];
    }

    if (response.data == 0) {
      return [];
    }
  }
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Startup Name Generator',
//      theme: new ThemeData(
//        primaryColor: Colors.white,
//      ),
//      home: new RandomWords(),
//    );
//  }
//}
//
//class RandomWords extends StatefulWidget {
//  @override
//  createState() => new RandomWordsState();
//}
//
//class RandomWordsState extends State<RandomWords> {
//  var _suggestions = [];
//
//  final _saved = new Set();
//
//  final _biggerFont = const TextStyle(fontSize: 18.0);
//
//  final _baseUrl = 'http://smh.51simuhui.com/site/';
//
//  final _baseImageUrl = 'http://smh.51simuhui.com/image/';
//
//  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('about bys test'),
//        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
//        ],
//      ),
//      body: _buildSuggestions(),
//    );
//  }
//
//  Widget _buildSuggestions() {
//    _getImagesList();
//    return new ListView.builder(
//      padding: const EdgeInsets.all(16.0),
//      itemBuilder: (context, i) {
//        if (i.isOdd) return new Divider();
//
//        final index = i ~/ 2;
//
//        return _buildRow([]);
//      },
//    );
//  }
//
//  Widget _buildRow(pair) {
//    return new ListView(shrinkWrap: true,children: <Widget>[
//
//      new Text('资源图片：'),
//      new Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          new Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: CachedNetworkImage(
//              imageUrl: 'http://smh.51simuhui.com/image/1.jpg',
//              width: 120,
//              fit: BoxFit.fitWidth,
//            ),
//          ),
//        ],
//      )
//    ]);
//  }
//
//  _getImagesList() async {
//    Dio dio = new Dio();
//    Response response;
//    response = await dio.get(_baseUrl + "image");
//
//    if (response.data == 0) {
//      return [];
//    }
//
//    var result = json.decode(response.data);
//    var image = new ImageModel();
//    for (var x in result) {
//      image = ImageModel.fromJson(x);
//    }
//
//    print(image.url);
//    return image;
//  }
//
//  void _pushSaved() {
//    Navigator.of(context).push(
//      new MaterialPageRoute(
//        builder: (context) {
//          final tiles = _saved.map(
//            (pair) {
//              return new ListTile(
//                title: new Text(
//                  pair.asPascalCase,
//                  style: _biggerFont,
//                ),
//              );
//            },
//          );
//          final divided = ListTile.divideTiles(
//            context: context,
//            tiles: tiles,
//          ).toList();
//
//          return new Scaffold(
//            appBar: new AppBar(
//              title: new Text('Saved Suggestions'),
//            ),
//            body: new ListView(children: divided),
//          );
//        },
//      ),
//    );
//  }
//}
