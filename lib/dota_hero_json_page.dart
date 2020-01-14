import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DotaHeroJsonPage extends StatefulWidget {
  @override
  _DotaHeroJsonPageState createState() => _DotaHeroJsonPageState();
}

class _DotaHeroJsonPageState extends State<DotaHeroJsonPage> {
  String url =
      "https://raw.githubusercontent.com/joshuaduffy/dota2api/master/dota2api/ref/heroes.json";
  List<Map<String, dynamic>> heroList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dota Hero Json page")),
      body: heroList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: heroList.map((data) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          data["name"],
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Image.network(data["full_portrait"])
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }

  getData() async {
    await http.get(url).then((response) {
      Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData["count"]);

      List<dynamic> heroDataList = responseData["heroes"];
      print(responseData["heroes"]);
      List<Map<String, dynamic>> finalResult = [];
      heroDataList.forEach((data) {
        Map<String, dynamic> map = {
          "name": data["localized_name"],
          "full_portrait": data["url_full_portrait"],
          "vertical_portrait": data["url_vertical_portrait"]
        };
        finalResult.add(map);
      });
      setState(() {
        heroList = finalResult;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
}
