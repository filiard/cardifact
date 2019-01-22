class GameCard{

  int _idCard;
  String _color, _type, _rarity, _name, _description;
  int _goldCost;
  int _manaCost;
  int _health;
  int _armor;
  int _attack;

  GameCard.item(this._idCard, this._color, this._type, this._rarity, this._name, this._goldCost, this._description);

  GameCard.improvement(this._idCard, this._color, this._type, this._rarity, this._name, this._manaCost, this._description );

  GameCard.spell(this._idCard, this._color, this._type, this._rarity, this._name, this._manaCost);

  GameCard.creep(this._idCard, this._color, this._type, this._rarity, this._name, this._manaCost, this._attack, this._health, this._description);

  GameCard.hero(this._idCard, this._color, this._type, this._rarity, this._name, this._attack, this._health, this._armor, this._description);

  int get attack => _attack;

  int get armor => _armor;

  int get health => _health;

  int get manaCost => _manaCost;

  int get goldCost => _goldCost;

  get name => _name;

  get rarity => _rarity;

  get type => _type;

  String get color => _color;

  String get description => _description;

  int get idCard => _idCard;

  set attack(int value) {
    _attack = value;
  }

  set armor(int value) {
    _armor = value;
  }

  set health(int value) {
    _health = value;
  }

  set manaCost(int value) {
    _manaCost = value;
  }

  set goldCost(int value) {
    _goldCost = value;
  }

  set name(value) {
    _name = value;
  }

  set rarity(value) {
    _rarity = value;
  }

  set type(value) {
    _type = value;
  }

  set color(value) {
    _color = value;
  }
  set description (value){
    _description=value;
  }


  Map <String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    map['idCard'] = _idCard;
    map['color'] = _color;
    map['type'] = _type;
    map['rarity'] = _rarity;
    map['name'] = _name;
    map['goldCost'] = _goldCost;
    map['manaCost'] = _manaCost;
    map['armor'] = _armor;
    map['attack']= _attack;
    map['health']= _health;
    map['description']=_description;


    return map;
  }

  GameCard.fromMapObject(Map<String, dynamic> map)
  {
    this._idCard=map['idCard'];
    this._color= map['color'];
    this._type= map['type'];
    this._rarity = map['rarity'];
    this._name = map['name'];
    this._goldCost=map['goldCost'];
    this._manaCost=map['manaCost'];
    this._armor = map['armor'];
    this._attack = map['attack'];
    this._health= map['health'];
    this._description=map['description'];


  }


}