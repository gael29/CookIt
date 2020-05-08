import 'dart:async';
import 'dart:io';

import 'package:flutter_ecommerce_app/src/model/recipe.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Cook.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Fav ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "readyInMinutes INTEGER,"
          "image TEXT,"
          "isLiked INTEGER,"
          "isOnList INTEGER"
          ")");
    });
  }

  newFav(Recipe newRecipe) async {
    final db = await database;
    int isLiked = newRecipe.isLiked ? 1 : 0;
    int isOnList = newRecipe.isOnList ? 1 : 0;
    //await db.execute("DROP TABLE IF EXISTS Fav");
        //insert to the table using the new id
    
    var raw = await db.rawInsert(
        "INSERT Into Fav (id,name,readyInMinutes,image,isLiked,isOnList)"
        " VALUES (?,?,?,?,?,?)",
        [newRecipe.id, newRecipe.name,newRecipe.readyInMinutes,newRecipe.image,isLiked,isOnList]);
    return raw;
  }

  // getAllFav() async {
  //   final db = await database;
  //   var res = await db.rawQuery("SELECT * FROM Fav");
  //   List<Recipe> list =
  //       res.isNotEmpty ? res.toList().map((c) => Recipe.fromMap(c)) : null;
  //   return list;
  // }

  Future<List<Recipe>> getAllFav() async {
    final db = await database;
    var res = await db.query("Fav");
    List<Recipe> list =
        res.isNotEmpty ? res.map((c) => Recipe.fromMap(c)).toList() : [];
    return list;
  }

  deleteFav(int id) async {
    final db = await database;
    return db.delete("Fav", where: "id = ?", whereArgs: [id]);
  }

Future<List<Recipe>> getFav(int id) async {
    final db = await database;
    var res = await db.query("Fav", where: "id = ?", whereArgs: [id]);
    List<Recipe> list =
        res.isNotEmpty ? res.map((c) => Recipe.fromMap(c)).toList() : [];
    return list;
  }



  // blockOrUnblock(Client client) async {
  //   final db = await database;
  //   Client blocked = Client(
  //       id: client.id,
  //       firstName: client.firstName,
  //       lastName: client.lastName,
  //       blocked: !client.blocked);
  //   var res = await db.update("Client", blocked.toMap(),
  //       where: "id = ?", whereArgs: [client.id]);
  //   return res;
  // }

  // updateClient(Client newClient) async {
  //   final db = await database;
  //   var res = await db.update("Client", newClient.toMap(),
  //       where: "id = ?", whereArgs: [newClient.id]);
  //   return res;
  // }

  // getClient(int id) async {
  //   final db = await database;
  //   var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? Client.fromMap(res.first) : null;
  // }

  // Future<List<Client>> getBlockedClients() async {
  //   final db = await database;

  //   print("works");
  //   // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
  //   var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

  //   List<Client> list =
  //       res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
  //   return list;
  // }

  // Future<List<Client>> getAllClients() async {
  //   final db = await database;
  //   var res = await db.query("Client");
  //   List<Client> list =
  //       res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
  //   return list;
  // }

  

  // deleteAll() async {
  //   final db = await database;
  //   db.rawDelete("Delete * from Client");
  // }
}