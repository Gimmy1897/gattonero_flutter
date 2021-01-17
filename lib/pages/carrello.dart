import 'package:flutter/material.dart';

class CarrelloPage extends StatefulWidget {
  @override
  CarrelloPageState createState() => CarrelloPageState();
}

class CarrelloPageState extends State<CarrelloPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Text("Questa è il carrello gimmy"),
      ),
    );
  }
}
