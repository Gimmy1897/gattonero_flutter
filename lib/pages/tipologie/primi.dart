import 'package:flutter/material.dart';
import 'package:gattonero_flutter/res/res.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Primi extends StatefulWidget {
  @override
  PrimiState createState() => PrimiState();
}

class PrimiState extends State<Primi> {
  final formatprezzo = new NumberFormat("#,##0.00", "it_IT");
  @override
  void initState() {
    super.initState();
    Hive.initFlutter();
  }

  dispose() {
    super.dispose();
  }

  Box primiBox;
  Future<dynamic> getPrimi() async {
    List listaprimi;
    primiBox = await Hive.openBox('primi');
    if (primiBox.isNotEmpty) {
      listaprimi = null;
      listaprimi = primiBox.toMap().values.toList();
      print("box primi pieno");
    } else {
      print("box primi vuoto");
    }
    //print(listaprimi);
    return listaprimi;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      child: FutureBuilder(
          future: getPrimi(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.data.length != 0) {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  )),
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return listItem(context, index, snapshot);
                      }));
            } else {
              return Container(
                child: Center(
                  child: Text("attendere..."),
                ),
              );
            }
          }),
    ));
  }

  Widget listItem(BuildContext context, int index, AsyncSnapshot snapshot) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child: ClipOval(
                child: Material(
                    color: Colori.primaryDark,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: Text("0",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    )),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 5, 10),
              child: Text(snapshot.data[index]["Descrizione"],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7)))),
          Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      formatprezzo
                              .format(
                                  double.parse(snapshot.data[index]["Prezzo"]))
                              .toString() +
                          "€",
                      style: TextStyle(
                          color: Colori.primaryLight,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)))),
          Expanded(child: Container()),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 5, 10),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  color: Colori.primaryLight, // button color
                  child: InkWell(
                    splashColor: Colors.white.withAlpha(20),
                    child: Container(
                      padding: EdgeInsets.all(10), // inkwell color
                      child: Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                    onTap: () {},
                  ))),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 5, 10),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  color: Colori.primaryDark, // button color
                  child: InkWell(
                    splashColor: Colors.white.withAlpha(60),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      // inkwell color
                      child: Icon(Icons.remove, color: Colors.white, size: 20),
                    ),
                    onTap: () {},
                  )))
        ],
      ),
    );
  }
}
