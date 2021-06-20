import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:sqlite_interestModel.dart';
import 'package:sqflite/sqflite.dart';

import 'InterestModel.dart';
import 'package:platform/platform.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
 

class DBProvider {
  // DBProvider._();

  // static final DBProvider db = DBProvider._();

  // static late Database? _database;  

  static final DBProvider _instance = new DBProvider.internal();
  factory DBProvider() => _instance;
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }
  DBProvider.internal();


  // Future<Database?> get database async {
  //   if (_database != null) return _database;
  //   // if _database is null we instantiate it
  //   _database;
  //   return _database;
  // }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Interest.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE InterestHistory ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "from_date TEXT,"
          "to_date TEXT,"
          "amount INTEGER,"
          "rate REAL,"
          "total REAL"          
          ")");
    });
  }

//   Future<Directory> getApplicationDocumentsDirectory() async {
    
//   final String? path = await platform getApplicationDocumentsPath();
//   if (path == null) {
//     throw MissingPlatformDirectoryException(
//         'Unable to get application documents directory');
//   }
//   return Directory(path);
// }

  addInterestHistory(InterestHistory newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db!.rawQuery("SELECT COALESCE(MAX(id), 0) + 1 as id FROM InterestHistory");
    int id = table.first["id"] as int;
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into InterestHistory (id, title, from_date, to_date, amount, rate, total)"
        " VALUES (?,?,?,?,?,?,?)",
        [id, newClient.title, newClient.fromDate, newClient.toDate, newClient.amount, newClient.rate, newClient.total]);
    return raw;
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

  getHistoryById(int id) async {
    final db = await database;
    var res = await db!.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? InterestHistory.fromMap(res.first) : null;
  }

  // Future<List<Client>> getBlockedClients() async {
  //   final db = await database;

  //   print("works");
  //   // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
  //   var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

  //   List<Client> list =
  //       res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
  //   return list;
  // }

  Future<List<InterestHistory>> getAllHistory() async {
    final db = await database;
    var res = await db!.query("InterestHistory");
    List<InterestHistory> list;
    if (res.isNotEmpty) {
      list = res.map( (c) { 
        //c["rate"] = double.parse(c["rate"].toString());
        // c["total"] = double.parse(c["total"].toString());
        return InterestHistory.fromMap(c); 
        }).toList();
    } else {
      list = [];
    }
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db!.delete("InterestHistory", where: "id = ?", whereArgs: [id]);
  }

  // deleteAll() async {
  //   final db = await database;
  //   db.rawDelete("Delete * from Client");
  // }
}