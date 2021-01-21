import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:gattonero_flutter/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://www.assassieglio.altervista.org/api/Listino.php";
bool isconnected = false;
Box primiBox;
Box secondiBox;
Box contorniBox;
Box dessertBox;
Box bibiteBox;

class HttpService {
  Future<bool> updateListino() async {
    Hive.initFlutter();
    primiBox = await Hive.openBox('primi');
    secondiBox = await Hive.openBox('secondi');
    contorniBox = await Hive.openBox('contorni');
    dessertBox = await Hive.openBox('dessert');
    bibiteBox = await Hive.openBox('bibite');
    //controllo se le box sono vuote, orgo se è vuota va sempre aggiornata(primo avvio dell'app o dati cancellati)
    //se vuoto
    if (!primiBox.isNotEmpty) {
      await checkConnection();
      if (isconnected) {
        await saveListino();
        BottomNavBar.isupdated = true;
        return true;
      } else {
        print("nessuna connessione");
        return false;
      }
      //se le box sono piene
    } else {
      //controlla se sono state gia aggiorante, ergo l'app ha aggiornato i dati una volta avviata
      if (BottomNavBar.isupdated) {
        return true;
        //i dati non sono ancora stati aggiornati all'apertura
      } else {
        //controllo la connessione
        await checkConnection();
        //sono connessio allora aggiorno e modifico la bool isupdated
        if (isconnected) {
          await saveListino();
          BottomNavBar.isupdated = true;
          return true;
          //nessuna connessione riprova
        } else {
          print("nessuna connessione");
          return false;
        }
      }
    }
  }

  Future saveListino() async {
    String url = "https://assassieglio.altervista.org/api/Listino.php";
    try {
      var response = await http.get(url);
      String jsonraw = "[" + response.body.toString().split("[")[1];
      var jsondecode = jsonDecode(jsonraw);
      await bibiteBox.clear();
      await primiBox.clear();
      await secondiBox.clear();
      await contorniBox.clear();
      await dessertBox.clear();
      insertData(jsondecode);
      print("listino primi salvato");
    } catch (SocketException) {
      print(SocketException.toString());
    }
  }

  insertData(var json) {
    for (var d in json) {
      var tipo = d["Tipologia"];
      switch (tipo) {
        case "Primi":
          primiBox.add(d);
          break;
        case "Secondi":
          secondiBox.add(d);
          break;
        case "Contorni":
          contorniBox.add(d);
          break;
        case "Dessert":
          dessertBox.add(d);
          break;
        case "Bibite":
          bibiteBox.add(d);
          break;
      }
    }
    return true;
  }

  checkConnection() async {
    int timeout = 5;
    try {
      http.Response response = await http
          .get('https://www.assassieglio.altervista.org/api/check.php')
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        isconnected = true;
      } else {
        isconnected = false;
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (b) {
      print('Socket Error: $b');
    } on Error catch (c) {
      print('General Error: $c');
    }
  }

  createBox() async {
    try {} catch (Exception) {
      print(Exception.toString());
    }
  }
}
