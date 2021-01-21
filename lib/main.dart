import 'package:flutter/material.dart';
import 'package:gattonero_flutter/navigator/navigator.dart';
import 'package:gattonero_flutter/pages/carrello.dart';
import 'package:gattonero_flutter/pages/listino.dart';
import 'package:gattonero_flutter/pages/home.dart';
import 'package:gattonero_flutter/res/res.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colori.primaryDark,
            accentColor: Colori.primaryLight),
        builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
            ),
        home: BottomNavBar());
  }
}

class BottomNavBar extends StatefulWidget {
  static bool isupdated = false;
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
          height: 60.0,
          items: <Widget>[
            Icon(Icons.receipt, size: 40, color: Colors.white),
            Icon(Icons.home, size: 40, color: Colors.white),
            Icon(Icons.shopping_cart, size: 40, color: Colors.white),
          ],
          color: Color(0xff03A9F4),
          buttonBackgroundColor: Color(0xff03A9F4),
          backgroundColor: Colori.grigio_bg,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 450),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Center(
            child: Container(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: listapagine[_page],
                ),
              ),
            ],
          ),
        )));
  }
}
