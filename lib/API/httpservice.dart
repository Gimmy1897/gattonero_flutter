import 'dart:async';
import 'dart:convert';
import 'package:gattonero_flutter/models/model_listino.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

const baseUrl = "https://www.assassieglio.altervista.org/api/Listino.php";

class HttpService {
  Future<List<Listino>> getListino() async {
    var listinodata = await http.get(baseUrl);
    var jsonData = json.decode(listinodata.body);
    List<Listino> listaListino = [];
    for (var item in jsonData) {
      Listino listino = Listino(item["Descrizione"], item["Tipologia"],
          item["Prezzo"], item["Disponibilita"]);
      listaListino.add(listino);
    }
    return listaListino;
  }
}
