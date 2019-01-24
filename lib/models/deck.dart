class Deck{
  int _id_deck;
  String _nameDeck;

  Deck(this._id_deck, this._nameDeck);

  String get nameDeck => _nameDeck;

  int get id_deck => _id_deck;

  set nameDeck(String value) {
    _nameDeck = value;
  }

  set id_deck(int value) {
    _id_deck = value;
  }

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['id_deck'] =_id_deck;
    map['nameDeck'] = _nameDeck;

    return map;
  }

  Deck.fromMapObject(Map<String, dynamic> map)
  {
    this._id_deck=map['id_deck'];
    this._nameDeck=map['nameDeck'];
  }

}