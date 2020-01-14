import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoJsonPage extends StatefulWidget {
  @override
  _PhotoJsonPageState createState() => _PhotoJsonPageState();
}

class _PhotoJsonPageState extends State<PhotoJsonPage> {
  String url = "https://jsonplaceholder.typicode.com/photos";
  List<Map<String, dynamic>> photoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Json Page"),
      ),
      body: photoList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: photoList.map((photoListData) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      Image.network(photoListData["url"]),
                      Text(photoListData["title"])
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }

  getData() async {
    await http.get(url).then((response) {
      List<dynamic> responseData = json.decode(response.body);
      List<Map<String, dynamic>> dataList = [];

      responseData.forEach((data) {
        Map<String, dynamic> mapData = {
          "title": data["title"],
          "url": data["url"]
        };
        dataList.add(mapData);
      });
      setState(() {
        photoList = dataList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
}
