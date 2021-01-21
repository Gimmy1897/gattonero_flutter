import 'package:flutter/material.dart';
import 'package:gattonero_flutter/res/res.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                    colors: [Colori.primaryDark, Colori.primaryLight])),
            child: Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 40.0,
                          decoration: new BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: new BorderRadius.vertical(
                                bottom: new Radius.elliptical(150, 120.0)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text(
                            "Sagra Del Gatto Nero",
                            style: GoogleFonts.courgette(
                                fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            color: Colori.grigio_bg,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0),
                            ))))
              ],
            )));
  }
}

/*       Center(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                  bottomLeft: Radius.circular(50.0),
                  topLeft: Radius.circular(50.0),
                ),
                color: Colors.white),
            child: Material(
              elevation: 5,
              color: Color(0xff03A9F4),
              type: MaterialType.circle,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.add, size: 40, color: Colors.white),
              ),
            ),
          ),
        ),*/
