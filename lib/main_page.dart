import 'package:flutter/material.dart';
import 'package:networking_basic/dota_hero_json_page.dart';
import 'package:networking_basic/parse_json_page.dart';
import 'package:networking_basic/photo_json_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return PostJsonPage();
              }));
            },
            child: Text("Post Json Parsing"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return PhotoJsonPage();
              }));
            },
            child: Text("Photo Json Parsing"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return DotaHeroJsonPage();
              }));
            },
            child: Text("Dota Heros Json Parsing"),
          )
        ],
      ),
    );
  }
}
