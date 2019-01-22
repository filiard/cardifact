import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'models/gameCard.dart';
import 'models/deck.dart';

class DBProvider {
  static DBProvider _databasehelper;
  static Database _database;

  DBProvider._createInstance();

  factory DBProvider() {
    if (_databasehelper == null) {
      _databasehelper = DBProvider._createInstance();
    }
    return _databasehelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }

    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "baza.db";
    var cardsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return cardsDatabase;
  }

  Future<Database> initDecksDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "baza2.db";
    var cardsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDecksDb);
    return cardsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE cards (id_card INTEGER PRIMARY KEY, 
         color TEXT, type TEXT, rarity TEXT, name TEXT UNIQUE, goldCost INTEGER,
         manaCost INTEGER, armor INTEGER, attack INTEGER, health INTEGER, description TEXT)''');

    //await db.execute('''CREATE TABLE decks (id_deck INTEGER PRIMARY KEY, nameDeck TEXT)''');
    //await db.execute('''CREATE TABLE cards_decks(cards_cardId INTEGER, decks_deckId INTEGER, FOREIGN KEY(cards_cardId) REFERENCES cards(id_card), FOREIGN KEY(decks_deckId) REFERENCES decks(id_deck)''');

    await db.execute(
        '''INSERT INTO cards VALUES (1,'red','hero','rare',"Axe",NULL,NULL,2,6,10, "Axe is a man of many talents. Well one talent. The murder talent. However that seems to be enough for Axe to attract a legion of devoted fans that follow his adventures. It also probably helps that Axe's bard, Goodkind is good at what she calls 'embellishment' - Axe is unsure what the word means, but it's probably a good thing."),
                                                 (2,'red','hero','common','Beastmaster',NULL,NULL,NULL,5,15, "Every year the Marrowfell Centaurs send their bravest warriors into Roseleaf to hunt Thunderhides... to them this gruesome safari is a rite of passage, but I will not let these majestic creatures be hunted for sport. The only question that remains is how many centaurs will I have to kill before they realize Roseleaf Forest is no longer their hunting grounds."),
                                                 (3,'red','hero','common','Bristleback',NULL,NULL,NULL,8,12, "I never went to some fancy military school to learn how to beat a man half to death... that's what bars were for."),
                                                 (4,'red','hero', 'rare', 'Centaur Warruner',NULL,NULL,NULL,4,14, "The hunt is a sacred thing, and to be asked to lead it is a great honor. These centaurs claim to be the finest hunters of the Marrowfell Tribe. We shall see if any of them are worthy to claim the Horn of the Alpha."),
                                                 (5,'red','hero', 'basic', 'Keefe the Bold',NULL,NULL,1,6,11, "Fighting is like crushing someone's skull with a tree trunk. That's an analogy!"),
                                                 (6,'red','hero', 'uncommon', 'Legion Commander',NULL,NULL,1,6,8, "I know these people think me a monster. I don't blame them. No one wants to be occupied, but it's in their best interests! If we weren't here in Roseleaf the Red Mist would have slaughtered them all... today the Vhoul see us as villains, but after we defeat Sorla Khan... The Bronze Legion will be heralded as the heroes we are."),
                                                 (7,'red','hero', 'common', 'Mazzie',NULL,NULL,3,6,6, "So there I was: drinking with my friends, well actually I was drinking alone but I was thinking about my friends so it's basically the same thing. Anyway. Sniper walks into my workshop and is like 'Mazzie, you're wasting your life' and I'm like 'Geeze Sniper, if I wanted to feel bad about myself I'd ask my parents why they never visit me on my birthday' but Sniper's not interested in hearing about parental abandonment, he's interested in uniting the Keenfolk clans. So I say I'll help: on the condition that I get to give our group a cool name. Sniper rolled his eyes and sighed, which is basically the same thing as a yes, and THAT'S how the Society of Likeminded Keenfolk was born."),
                                                 (8,'red','hero', 'rare', 'Pugna',NULL,NULL,NULL,6,9, "PlayThe Tyler Estate. It seeks to control magic. Punish those that violate rules set by the Quorum. But I will show them that some things cannot be controlled. And when the Tyler Estate Burns, I will set my sights on Weeping Rose itself."),
                                                 (9,'red','hero', 'common', 'Sven',NULL,NULL,NULL,5,11, "PlayI've given myself to the Vigil Knights. I will train with them. Learn their ways. Become the best... and ultimately: destroy them from within."),
                                                 
                                                 (11,'red','hero', 'uncommon', 'Timbersaw',NULL,NULL,NULL,4,11, "PlayI know they think I'm crazy... and that's ok... they didn't see what I saw... see what the trees did. 'Ohh it's nature, look at the beauty of the forest.' Lies. That's not a tranquil jungle... that's a sleeping army. And unless we are prepared when that forest starts to march it will be the end of everybody."),
                                                 (12,'red','hero', 'common', 'Ursa',NULL,NULL,NULL,7,10, "PlayThis isn't my fight. But if I don't stand with the Vhoul it's only a matter of time before the Bronze Legion comes for my people. A message needs to be sent... and it will be bloody."),
                                                 (13,'red','improvement', 'uncommon', 'Burning Oil',NULL,1,NULL,NULL,NULL, "Your tower has +2 Retaliate."),
                                                 (14,'red','spell', 'basic', 'Double Edge',NULL,1,NULL,NULL,NULL, "Give a red hero +8 Attack and -8 Armor this round."),
                                                 (15,'red','spell', 'common', 'Fight Through the Pain',NULL,1,NULL,NULL,NULL, "Give a red hero +2 Armor this round. Get initiative."),
                                                 (16,'red','spell', 'basic', 'Kraken Shell',NULL,1,NULL,NULL,NULL, "Modify a red hero with +1 Armor.  Get initiative."),
                                                 (17,'red','spell', 'common', 'New Orders',NULL,1,NULL,NULL,NULL, "Choose an ally. Choose a combat target for it."),
                                                 (18,'red','spell', 'common', 'Poised to Strike',NULL,1,NULL,NULL,NULL, "Give a red hero +4 Attack this round."),
                                                 (19,'red','creep', 'common', 'Bronze Legionnaire',NULL,2,2,2,4, "The Red Mist Horde is on the march, looting and destroying every city that stands between them and our great capital of Stonehall. If we wish to protect our home...if we wish to stop these monsters... we must be willing to do whatever it takes."),
                                                 (20,'red','spell', 'common', 'Defensive Stance',NULL,2,NULL,NULL,NULL, "Give a hero +3 Armor this round."),
                                                 (21,'red','spell', 'basic', 'Duel',NULL,2,NULL,NULL,NULL, "Choose an allied red hero and another unit. They battle each other."),
                                                 (22,'red','spell', 'rare', 'Heroic Resolve',NULL,2,NULL,NULL,NULL, "Modify a red hero with 'After you play a non-item card costing 2 or less, modify this hero with +2 Health.'"),
                                                 (23,'red','spell', 'common', 'Pick a Fight',NULL,2,NULL,NULL,NULL, "Choose an allied hero. It taunts. Choose a combat target for it."),
                                                 (24,'red','spell', 'rare', 'Rising Anger',NULL,2,NULL,NULL,NULL, "Modify a red hero with 'After you play a non-item card costing 2 or less, modify this hero with +1 Attack.'") ,                                                
                                                 (25,'red','spell', 'basic', 'Whirling Death',NULL,2,NULL,NULL,NULL, "Choose an allied red hero. Deal 2 damage to its enemy neighbors and give them -2 Attack this round."),
                                                 (26,'red','spell', 'common', 'Combat Training',NULL,3,NULL,NULL,NULL, "Modify a hero with +2 Attack."),
                                                 (27,'red','improvement', 'rare', 'Grand Melee',NULL,3,NULL,NULL,NULL, "If there is an allied red hero in this lane, all heroes have +2 Cleave."),
                                                 (28,'red','creep', 'common', 'Hellbear Crippler',NULL,3,NULL,3,3, "When Hellbear Crippler deals battle damage to a unit, modify that unit with -1 Attack."),
                                                 (29,'red','creep', 'basic', 'Loyal Beast',NULL,3,1,3,3, "When Loyal Beast deals battle damage to a unit, modify that unit with -1 Attack."),
                                                 (30,'red','creep', 'rare', 'Mercenary Exiles',NULL,3,1,2,4, "Active 2: Spend all your gold. Modify Mercenary Exiles with +X Attack and +X Health where X is half the gold spent."),
                                                 (31,'red','improvement', 'rare', 'Path of the Bold',NULL,3,NULL,NULL,NULL, "After you play a red card, modify a random ally with +1 Attack."),
                                                 (32,'red','spell', 'uncommon', 'Rend Armor',NULL,3,NULL,NULL,NULL, "Modify a unit with -X Armor where X is its Armor."),
                                                 (33,'red','spell', 'uncommon', 'Smash Their Defenses!',NULL,3,NULL,NULL,NULL, "Condemn an improvement. Draw a card."),
                                                 (34,'red','spell', 'uncommon', 'Spot Weakness',NULL,3,NULL,NULL,NULL, "Give a hero and its allied neighbors Pierce this round. Draw a card."),
                                                 (35,'red','improvement', 'uncommon', 'Temple of War',NULL,3,NULL,NULL,NULL, "All equipped heroes have +2 Attack and +1 Armor."),
                                                 (36,'red','spell', 'common', 'Clear the Deck',NULL,4,NULL,NULL,NULL, "Give allied heroes +4 Cleave this round."), 
                                                 (37,'red','spell', 'common', 'Crippling Blow',NULL,4,NULL,NULL,NULL, "Modify a hero with -2 Attack."),
                                                 (38,'red','spell', 'basic', 'Enrage',NULL,4,NULL,NULL,NULL, "Give a red hero +4 Attack and +4 Armor this round."), 
                                                 (39,'red','creep', 'uncommon', 'Legion Standard Bearer',NULL,4,NULL,NULL,NULL, "Legion Standard Bearer's allied neighbors have +4 Attack."), 
                                                 (40,'red','improvement', 'basic', 'Nether Ward',NULL,4,NULL,NULL,NULL, "After opponent plays a spell, deal 3 damage to the enemy tower.")


                                                 
                                                 ''');
  }

  void _createDecksDb(Database db, int newVersion) async {
    await db.execute(
        '''CREATE TABLE decks (id_deck INTEGER PRIMARY KEY, nameDeck TEXT)''');
    await db.execute(
        '''INSERT INTO decks VALUES (1, "nazwadecku")''');
  }

  //fetch all cards

  Future<List<Map<String, dynamic>>> getCardMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM cards ORDER BY name COLLATE NOCASE');

    return result;
  }

  Future<List<Map<String, dynamic>>> getFilteredCardMapList(
      String query) async {
    Database db = await this.database;
    var result = await db.rawQuery(query);
    return result;
  }

  //felch all decks

  Future<List<Map<String, dynamic>>> getDeckMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM decks ');

    return result;
  }

  Future<List<GameCard>> getCardList() async {
    var gameCardMapList = await getCardMapList();
    int count = gameCardMapList.length;
    List<GameCard> gameCardList = List<GameCard>();
    for (int i = 0; i < count; i++) {
      gameCardList.add(GameCard.fromMapObject(gameCardMapList[i]));
    }
    return gameCardList;
  }

  ///ogólnie to mi wykona każde query jakie mu wsadze
  Future<List<GameCard>> getFilteredCardList(String query) async {
    var gameCardMapList = await getFilteredCardMapList(query);
    int count = gameCardMapList.length;
    List<GameCard> gameCardList = List<GameCard>();
    for (int i = 0; i < count; i++) {
      gameCardList.add(GameCard.fromMapObject(gameCardMapList[i]));
    }
    return gameCardList;
  }

  Future<List<Deck>> getDeckList() async {
    var deckMapList = await getDeckMapList();
    int count = deckMapList.length;

    List<Deck> deckList = List<Deck>();
    for (int i = 0; i < count; i++) {
      deckList.add(Deck.fromMapObject(deckMapList[i]));
    }

    return deckList;
  }

  void dajQuery(String query) async {
    Database db = await this.database;
    await db.execute(query);
  }
}
