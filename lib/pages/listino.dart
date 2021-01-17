import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class ListinoPage extends StatefulWidget {
  @override
  ListinoPageState createState() => ListinoPageState();
}

class ListinoPageState extends State<ListinoPage> {
  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  String baseUrl = "https://assassieglio.altervista.org/api/Listino.php";
  Future<List> getListino() async {
    var listinodata = await http.get(baseUrl);
    String jsonraw = "[" + listinodata.body.toString().split("[")[1];
    var jsonData = json.decode(jsonraw);
    List<String> piatti = [];
    for (var items in jsonData) {
      piatti.add(items["Descrizione"]);
    }
    return piatti;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: FutureBuilder(
            future: getListino(),
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
                      title: Text(snapshot.data[index]),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}

class Listino {
  String descrizione;
  String tipologia;
  String prezzo;
  String disponibilita;

  Listino(this.descrizione, this.tipologia, this.prezzo, this.disponibilita);
}

/*child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(lista[index]));
            }),
      ),*/
