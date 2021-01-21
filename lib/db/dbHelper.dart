import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

@override
Widget listViewListino(BuildContext context) {
  return new Scaffold(
    body: Center(
      child: FutureBuilder(
          future: updateListino(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Caricamento"),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index]["Descrizione"]),
                    subtitle: Text(snapshot.data[index]["Tipologia"]),
                  );
                },
              );
            }
          }),
    ),
  );
}

Box box;
List listino = [];
Future openBox() async {
  try {
    Hive.initFlutter();
    box = await Hive.openBox('listino');
  } catch (Exception) {
    print(Exception.toString());
  }
}

Future<List> updateListino() async {
  await openBox();
  String url = "https://assassieglio.altervista.org/api/Listino.php";
  try {
    var response = await http.get(url);
    String jsonraw = "[" + response.body.toString().split("[")[1];
    var jsondecode = jsonDecode(jsonraw);
    await putData(jsondecode);
  } catch (SocketException) {
    print(SocketException.toString());
  }
  var listinoMap = box.toMap().values.toList();
  return listino = listinoMap;
}

Future putData(data) async {
  await box.clear();
  for (var d in data) {
    box.add(d);
  }
}
