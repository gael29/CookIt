import 'dart:async';
import 'dart:io';

import 'package:cookit/src/model/ingredient.dart';
import 'package:cookit/src/model/recipe.dart';
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
      await db.execute("CREATE TABLE List ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "readyInMinutes INTEGER,"
          "image TEXT,"
          "isLiked INTEGER,"
          "isOnList INTEGER,"
          "servings INTEGER"
          ")");
      await db.execute("CREATE TABLE Ingredients ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "recipeId INTEGER,"
          "name TEXT,"
          "image TEXT,"
          "amount REAL,"
          "unit TEXT,"
          "isChecked INTEGER"
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
        [
          newRecipe.id,
          newRecipe.name,
          newRecipe.readyInMinutes,
          newRecipe.image,
          isLiked,
          isOnList
        ]);
    return raw;
  }

  newList(Recipe newRecipe) async {
    final db = await database;
    int isLiked = newRecipe.isLiked ? 1 : 0;
    int isOnList = newRecipe.isOnList ? 1 : 0;
    //await db.execute("DROP TABLE IF EXISTS Fav");
    //insert to the table using the new id
    print(newRecipe.servings);

    var raw = await db.rawInsert(
        "INSERT Into List (id,name,readyInMinutes,image,isLiked,isOnList,servings)"
        " VALUES (?,?,?,?,?,?,?)",
        [
          newRecipe.id,
          newRecipe.name,
          newRecipe.readyInMinutes,
          newRecipe.image,
          isLiked,
          isOnList,
          newRecipe.servings
        ]);
    return raw;
  }

  newIngredient(Ingredient newIng) async {
    final db = await database;
    int isChecked = newIng.isChecked ? 1 : 0;

    var raw = await db.rawInsert(
        "INSERT Into Ingredients (recipeId,name,image,amount,unit,isChecked)"
        " VALUES (?,?,?,?,?,?)",
        [
          newIng.recipeId,
          newIng.name,
          newIng.image,
          newIng.amount,
          newIng.unit,
          isChecked
        ]);
    return raw;
  }

  Future<List<Recipe>> getAllFav() async {
    final db = await database;
    var res = await db.query("Fav");
    List<Recipe> list =
        res.isNotEmpty ? res.map((c) => Recipe.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Map>> getFavList() async {
    final db = await database;
    List<Map> list = await db.query("Fav");
    return list;
  }

  Future<List<Map>> getPlanList() async {
    final db = await database;
    List<Map> list = await db.query("List");
    return list;
  }


  Future<List<Recipe>> getAllList() async {
    final db = await database;
    var res = await db.query("List");
    List<Recipe> list =
        res.isNotEmpty ? res.map((c) => Recipe.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Ingredient>> getAllIngredients() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Ingredients ORDER BY name ASC");
    List<Ingredient> list =
        res.isNotEmpty ? res.map((c) => Ingredient.fromMap(c)).toList() : [];
   // var dis = await db.rawQuery("SELECT DISTINCT name FROM Ingredients");
    //List[] names = dis.isNotEmpty ? dis.map((e) => null).toList() : [];
    
    // List<Ingredient> ing = new List<Ingredient>();

   //List newList = [];
  // print(list.length);

 
    // for(var ind = 0; ind < dis.length; ind++){
    //   double amount = 0;
    // // print(dis[0]['name']);

    //       for(var ing = 0; ing < list.length; ing++){
    //     if (dis[ind]['name'] == list[ing].name) {
    //       // print(dis[ind]);
    //       // print(list[ind].amount);
    //       list[ind].amount=list[ind].amount+amount;
    //       amount=list[ind].amount;
          
    //     //  if(ing>ind){
    //     //    list.removeAt(ing);
    //     //  }
    //     }
    //   }
    // }

      // List<Ingredient> lastList = newList.isNotEmpty ? newList.map((c) => Ingredient.fromMap(c)).toList() : [];


    

     //print(list.length);
    // print(dis.length);
  //  print(lastList.length);

    return list;
  }

  deleteFav(int id) async {
    final db = await database;
    return db.delete("Fav", where: "id = ?", whereArgs: [id]);
  }

  deleteList(int id) async {
    final db = await database;
    return db.delete("List", where: "id = ?", whereArgs: [id]);
  }

  deleteIngredient(int id) async {
    final db = await database;
    return db.delete("Ingredients", where: "recipeId = ?", whereArgs: [id]);
  }

  Future<List<Recipe>> getFav(int id) async {
    final db = await database;
    var res = await db.query("Fav", where: "id = ?", whereArgs: [id]);
    List<Recipe> list =
        res.isNotEmpty ? res.map((c) => Recipe.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Recipe>> getList(int id) async {
    final db = await database;
    var res = await db.query("List", where: "id = ?", whereArgs: [id]);
    List<Recipe> list =
        res.isNotEmpty ? res.map((c) => Recipe.fromMap(c)).toList() : [];
    return list;
  }

  updateServingsList(int id, int servings) async {
    final db = await database;
    var res = await db
        .rawUpdate('UPDATE List SET servings = ? WHERE id = ?', [servings, id]);
    //     int count = await database.rawUpdate(
    // 'UPDATE Test SET name = ?, value = ? WHERE name = ?',
    // ['updated name', '9876', 'some name']);
    return res;
  }

   updateShoppingListAmount(int id, double amount, String name) async {
    final db = await database;
    var res = await db
        .rawUpdate('UPDATE Ingredients SET amount = ?, isChecked=0 WHERE recipeId = ? AND name = ?', [amount, id, name]);
        print(amount.toString()+" "+id.toString()+" "+name);
    //     int count = await database.rawUpdate(
    // 'UPDATE Test SET name = ?, value = ? WHERE name = ?',
    // ['updated name', '9876', 'some name']);
    return res;
  }

  
  updateListChecked(String name, int check) async {
    final db = await database;
    var res = await db
        .rawUpdate('UPDATE Ingredients SET isChecked = ? WHERE name = ?', [check, name]);
    
    //     int count = await database.rawUpdate(
    // 'UPDATE Test SET name = ?, value = ? WHERE name = ?',
    // ['updated name', '9876', 'some name']);
    return res;
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
