import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostJsonPage extends StatefulWidget {
  @override
  _PostJsonPageState createState() => _PostJsonPageState();
}

class _PostJsonPageState extends State<PostJsonPage> {
  String url = "https://jsonplaceholder.typicode.com/posts";
  List<Map<String, dynamic>> postList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Networking Basic"),
      ),
      body: postList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: postList.map((dataList) {
                return Card(
                  child: ListTile(
                    title: Text(dataList["title"]),
                    subtitle: Text(dataList["body"]),
                    leading: Text(dataList["userId"].toString()),
                  ),
                );
              }).toList(),
            ),
    );
  }

  getData() async {
    await http.get(url).then((response) {
      List<dynamic> data = json.decode(response.body);
      print(data.length);
      List<Map<String, dynamic>> dataList = [];
      data.forEach((f) {
        Map<String, dynamic> map = {
          "userId": f["userId"],
          "id": f["id"],
          "title": f["title"],
          "body": f["body"]
        };
        dataList.add(map);
      });
      print(dataList.length.toString() + "post");
      setState(() {
        postList = dataList;
      });
    });
  }
}
