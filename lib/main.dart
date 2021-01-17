import 'package:flutter/material.dart';
import 'package:gattonero_flutter/navigator/navigator.dart';
import 'package:gattonero_flutter/pages/carrello.dart';
import 'package:gattonero_flutter/pages/listino.dart';
import 'package:gattonero_flutter/pages/home.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

final List<Widget> listapagine = [ListinoPage(), HomePage(), CarrelloPage()];

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.receipt, size: 30, color: Colors.white),
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          ],
          color: Color(0xff03A9F4),
          buttonBackgroundColor: Color(0xff03A9F4),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 450),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 80.0,
                decoration: new BoxDecoration(
                  color: Color(0xff03A9F4),
                  boxShadow: [new BoxShadow(blurRadius: 10.0)],
                  borderRadius: new BorderRadius.vertical(
                      bottom: new Radius.elliptical(
                          MediaQuery.of(context).size.width, 90.0)),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Text(
                      "Sagra Del Gatto Nero",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: listapagine[_page],
                ),
              ),
            ],
          ),
        ) //child: listapagine[_page]),
        );
    //));
  }
}

/*             ElevatedButton(
                  child: Text('Go To Page of index 2'),
                  onPressed: () {
                    final CurvedNavigationBarState navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState.setPage(1);
                  },
                ) **/
