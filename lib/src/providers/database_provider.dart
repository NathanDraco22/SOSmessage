import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SingletonDB {
  static Database _database;

  static final SingletonDB db = SingletonDB._();

  SingletonDB._();

  Future<Database>get database async { 
    if (_database != null) return _database;


    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async{

    Directory documentsPath = await getApplicationDocumentsDirectory();

    final path = join(documentsPath.path, "contactsDB.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, v)async{
        db.execute('''
          CREATE TABLE contacts(
            id INTEGER PRIMARY KEY,
            name TEXT,
            number TEXT
          )
        ''');
      }

    );

  }

  insertContact({@required String name, @required String number})async{
    final db = await database;
    final res = await db.insert("contacts", {"name": name, "number":number});
    return res;
  }

  Future<List<Map<String,dynamic>>> getAllContacts()async{
    final db = await database;
    final res = await db.query("contacts");
    return (res.isEmpty)
            ?[]
            :res;

  }

  deleteinDB(data)async {
    final db = await database;
    final res = await db.delete("contacts",where: "name = ?", whereArgs: [data]);
    return res;
  }
}