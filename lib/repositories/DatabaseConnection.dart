import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ta_bloc/models/Movie.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_movie');
    var database = await openDatabase(path,
        version: 1, onCreate: _onCreatingDatabase, onOpen: _onOpenDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    print('create Database');
    await db.execute(
        "CREATE TABLE movies(id INTEGER PRIMARY KEY, title TEXT, synopsis TEXT, image TEXT, genre TEXT, rating INTEGER)");
  }

  Future<FutureOr<void>> _onOpenDatabase(Database db) async {
    await db.execute("DROP TABLE IF EXISTS movies");
    await db.execute(
        "CREATE TABLE movies(id INTEGER PRIMARY KEY, title TEXT, synopsis TEXT, image TEXT, genre TEXT, rating INTEGER)");
    print("Database recreated");
    for (var i = 0; i < 10000; i++) {
      var movie = Movie(
          i,
          "Spiderman",
          "This movie is about a teenager that turns into",
          "image.jp",
          "Action",
          1);
      await db.insert('movies', movie.toMap());
    }
  }
}
