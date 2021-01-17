import 'dart:ffi';

class Listino {
  String descrizione;
  String tipologia;
  String prezzo;
  String disponibilita;

  Listino(String descrizione, String tipologia, String prezzo,
      String disponibilita) {
    this.descrizione = descrizione;
    this.tipologia = tipologia;
    this.prezzo = prezzo;
    this.disponibilita = disponibilita;
  }

  Listino.fromJson(Map json)
      : descrizione = json['Descrizione'],
        tipologia = json['Tipologia'],
        prezzo = json['Prezzo'],
        disponibilita = json['Disponibilita'];

  Map toJson() {
    return {
      'Descrizione': descrizione,
      'Tipologia': tipologia,
      'Prezzo': prezzo,
      'Disponibilita': disponibilita
    };
  }
}
