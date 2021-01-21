import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:gattonero_flutter/API/httpservice.dart';

class CarrelloPage extends StatefulWidget {
  @override
  CarrelloPageState createState() => CarrelloPageState();
}

class CarrelloPageState extends State<CarrelloPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(child: RaisedButton(onPressed: () {
        //HttpService service = new HttpService();
        //service.updateListino();
      })),
    );
  }
  /*
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
*/

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

  Widget piattiListaRow(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return Container(
        child: Expanded(
            child: Row(
      children: [
        Align(child: Container(child: Text(snapshot.data[index]["Quantita"])))
      ],
    )));
  }

  Future<List> updateListino() async {
    var listinoMap = [];
    await openBox();
    String url = "https://assassieglio.altervista.org/api/Listino.php";
    try {
      var response = await http.get(url);
      String jsonraw = "[" + response.body.toString().split("[")[1];
      var jsondecode = jsonDecode(jsonraw);
      if (response.statusCode == 200) {
        await putData(jsondecode);
        if (box.length == 0) {
          print("box vuota");
        } else {
          listinoMap = box.toMap().values.toList();
        }
      } else {
        print("Connessione assente o debole, codice: " +
            response.statusCode.toString());
      }
    } catch (SocketException) {
      print(SocketException.toString());
    }
    return listino = listinoMap;
  }

  Future putData(data) async {
    await box.clear();
    for (var d in data) {
      box.add(d);
    }
  }
}
