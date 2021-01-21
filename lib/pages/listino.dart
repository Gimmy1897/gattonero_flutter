import 'package:flutter/material.dart';
import 'package:gattonero_flutter/API/httpservice.dart';
import 'package:gattonero_flutter/pages/tipologie/primi.dart';
import 'package:gattonero_flutter/res/res.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListinoPage extends StatefulWidget {
  @override
  ListinoPageState createState() => ListinoPageState();
}

class ListinoPageState extends State<ListinoPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

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
            width: MediaQuery.of(context).size.width * 0.7,
            height: 40.0,
            decoration: new BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: new BorderRadius.vertical(
                  bottom: new Radius.elliptical(150, 120.0)),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  "Sagra Del Gatto Nero",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Center(child: _grigliaTipologie(context)),
          //contenitore liste
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colori.grigio_bg,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      )),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                      //lista
                      child: FutureBuilder(
                          future: updateListino(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            //print(snapshot.data);
                            if (snapshot.data == null) {
                              //print(snapshot);
                              return Container(
                                child: Center(
                                  child: new CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return listatipologie[0];
                            }
                          })))),
        ],
      ),
    ));
  }

  final List<Widget> listatipologie = [Primi()];
  int tipologiaindex = 0;

  Future<bool> updateListino() async {
    HttpService service = new HttpService();
    return service.updateListino();
  }

//Size default delle icone di tipolgia
  double secondiIconSize = 30;
  double primiIconSize = 40;
  double contorniIconSize = 30;
  double dessertIconSize = 30;
  double bevandeIconSize = 30;
//colore default delle icone
  Color bianco = Colors.white;
  Color primiIconColor = Colori.primaryDark;
  Color secondiIconColor = Colors.white;
  Color contorniIconColor = Colors.white;
  Color dessertIconColor = Colors.white;
  Color bevandeIconColor = Colors.white;

  Color neroAlpha = Colors.black.withAlpha(50);
  Color primiBg = Colors.white;
  Color secondiBg = Colors.black.withAlpha(50);
  Color contorniBg = Colors.black.withAlpha(50);
  Color dessertBg = Colors.black.withAlpha(50);
  Color bevandeBg = Colors.black.withAlpha(50);

  int lastModified = 0;

  void setIconProperties(int tipologia) {
    //setta grandezza icona
    if (tipologia != lastModified) {
      switch (lastModified) {
        case 0:
          primiIconSize = 30;
          primiIconColor = bianco;
          primiBg = neroAlpha;
          break;
        case 1:
          secondiIconSize = 30;
          secondiIconColor = bianco;
          secondiBg = neroAlpha;
          break;
        case 2:
          contorniIconSize = 30;
          contorniIconColor = bianco;
          contorniBg = neroAlpha;
          break;
        case 3:
          dessertIconSize = 30;
          dessertIconColor = bianco;
          dessertBg = neroAlpha;
          break;
        case 4:
          bevandeIconSize = 30;
          bevandeIconColor = bianco;
          bevandeBg = neroAlpha;
          break;
      }
      switch (tipologia) {
        case 0:
          primiIconSize = 40;
          primiIconColor = Colori.primaryDark;
          primiBg = bianco;
          lastModified = tipologia;
          break;
        case 1:
          secondiIconSize = 40;
          secondiIconColor = Colori.primaryDark;
          secondiBg = bianco;
          lastModified = tipologia;
          break;
        case 2:
          contorniIconSize = 40;
          contorniIconColor = Colori.primaryDark;
          contorniBg = bianco;
          lastModified = tipologia;
          break;
        case 3:
          dessertIconSize = 40;
          dessertIconColor = Colori.primaryDark;
          dessertBg = bianco;
          lastModified = tipologia;
          break;
        case 4:
          bevandeIconSize = 40;
          bevandeIconColor = Colori.primaryDark;
          bevandeBg = bianco;
          lastModified = tipologia;
          break;
      }
    }
  }

//Costruisce i bottoni delle tipologie in alto
  Widget _grigliaTipologie(BuildContext context) {
    var _widthScreen = MediaQuery.of(context).size.width;
    return Container(
        height: 80,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Center(
            child: Stack(children: <Widget>[
          //primi
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.fromLTRB(_widthScreen * 0.03, 0, 0, 0),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          setIconProperties(0);
                        });
                      },
                      child: Column(children: <Widget>[
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: primiBg,
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: AnimatedSize(
                                    curve: Curves.easeIn,
                                    vsync: this,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      MdiIcons.pasta,
                                      size: primiIconSize,
                                      color: primiIconColor,
                                    )))),
                        Text(
                          "Primi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])))),
          //secondi
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.fromLTRB(_widthScreen * 0.23, 0, 0, 0),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          setIconProperties(1);
                        });
                      },
                      child: Column(children: <Widget>[
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: secondiBg,
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: AnimatedSize(
                                    curve: Curves.easeIn,
                                    vsync: this,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      MdiIcons.foodDrumstick,
                                      size: secondiIconSize,
                                      color: secondiIconColor,
                                    )))),
                        Text(
                          "Secondi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])))),
          //contorni
          Align(
              alignment: Alignment.center,
              child: Container(
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          setIconProperties(2);
                        });
                      },
                      child: Column(children: <Widget>[
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: contorniBg,
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: AnimatedSize(
                                    curve: Curves.easeIn,
                                    vsync: this,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      MdiIcons.folderOutline,
                                      size: contorniIconSize,
                                      color: contorniIconColor,
                                    )))),
                        Text(
                          "Contorni",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])))),
          //dessert
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, _widthScreen * 0.23, 0),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          setIconProperties(3);
                        });
                      },
                      child: Column(children: <Widget>[
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: dessertBg,
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: AnimatedSize(
                                    curve: Curves.easeIn,
                                    vsync: this,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      MdiIcons.cupcake,
                                      size: dessertIconSize,
                                      color: dessertIconColor,
                                    )))),
                        Text(
                          "Dessert",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])))),
          //bevande
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, _widthScreen * 0.03, 0),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          setIconProperties(4);
                        });
                      },
                      child: Column(children: <Widget>[
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: bevandeBg,
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: AnimatedSize(
                                    curve: Curves.easeIn,
                                    vsync: this,
                                    duration: Duration(milliseconds: 300),
                                    child: Icon(
                                      MdiIcons.bottleWine,
                                      size: bevandeIconSize,
                                      color: bevandeIconColor,
                                    )))),
                        Text(
                          "Bibite",
                          style: TextStyle(color: Colors.white),
                        ),
                      ])))),
        ])));
  }
}

/*child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(lista[index]));
            }),
      ),*/
