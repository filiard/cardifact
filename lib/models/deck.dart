class Deck{
  int _idDeck;
  String _name;

  Deck(this._idDeck, this._name);

  String get name => _name;

  int get idDeck => _idDeck;

  set name(String value) {
    _name = value;
  }

  set idDeck(int value) {
    _idDeck = value;
  }

  Map <String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['idDeck'] =_idDeck;
    map['name'] = _name;

    return map;
  }

  Deck.fromMapObject(Map<String, dynamic> map)
  {
    this._idDeck=map['idDeck'];
    this._name=map['name'];
  }

}