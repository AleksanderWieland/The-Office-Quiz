import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/character.dart';
import '../models/quote.dart';

class DatabaseHelper {
  DatabaseHelper._privateContructor();
  static final DatabaseHelper instance = DatabaseHelper._privateContructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'theoffice.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE characters(
          id INTEGER PRIMARY KEY, 
          firstnameAndLastname TEXT)
          ''');
    await db.execute('''
          CREATE TABLE quotes(
          id INTEGER PRIMARY KEY, 
          quote TEXT, goodAnswer TEXT)
          ''');
  }

//IS TABLE EMPTY?
  Future<bool> isCharactersTableEmpty() async {
    Database db = await instance.database;
    int? count = Sqflite.firstIntValue(
        await db.rawQuery('''SELECT count(*) FROM characters'''));
    if (count == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isQuotesTableEmpty() async {
    Database db = await instance.database;
    int? count = Sqflite.firstIntValue(
        await db.rawQuery('''SELECT count(*) FROM quotes'''));
    if (count == 0) {
      return true;
    } else {
      return false;
    }
  }

//PRINT TABLES
  Future<void> printCharactersTable() async {
    Database db = await instance.database;
    print(await db.rawQuery('''SELECT * FROM characters'''));
  }

  Future<void> printQuotesTable() async {
    Database db = await instance.database;
    print(await db.rawQuery('''SELECT * FROM quotes'''));
  }

//GET TABLES
  Future<List<Character>> getCharacters() async {
    Database db = await instance.database;
    var characters = await db.query('characters');
    List<Character> characterList = characters.isNotEmpty
        ? characters.map((c) => Character.fromMap(c)).toList()
        : [];
    return characterList;
  }

  Future<List<Quote>> getQuotes() async {
    Database db = await instance.database;
    var quotes = await db.query('quotes');
    List<Quote> quotesList =
        quotes.isNotEmpty ? quotes.map((c) => Quote.fromMap(c)).toList() : [];
    return quotesList;
  }

//ADD OBJECTS TO DATABASE

  void addCharactersToDatabase(Map characters) async {
    List charactersIterable = characters['data'];
    for (int i = 0; i < charactersIterable.length; i++) {
      String firstnameAndLastname =
          '${charactersIterable[i]['firstname']} ${charactersIterable[i]['lastname']}';
      await instance.addCharacters(
        Character(firstnameAndLastname: firstnameAndLastname),
      );
    }
  }

  Future<int> addCharacters(Character character) async {
    Database db = await instance.database;
    return await db.insert('characters', character.toMap());
  }

  void addQuotesToDatabase(Map quotes) async {
    List quotesIterable = quotes['data'];
    for (int i = 0; i < quotesIterable.length; i++) {
      String goodAnswer =
          '${quotesIterable[i]['character']['firstname']} ${quotesIterable[i]['character']['lastname']}';
      await instance.addQuotes(
        Quote(quote: quotesIterable[i]['content'], goodAnswer: goodAnswer),
      );
    }
  }

  Future<int> addQuotes(Quote quote) async {
    Database db = await instance.database;
    return await db.insert('quotes', quote.toMap());
  }

//REMOVE OBJECTS FROM DATABASE
  Future<int> removeAllCharacters() async {
    Database db = await instance.database;
    return await db.rawDelete("Delete from characters");
  }

  Future<int> removeAllQuotes() async {
    Database db = await instance.database;
    return await db.rawDelete("Delete from quotes");
  }
}
