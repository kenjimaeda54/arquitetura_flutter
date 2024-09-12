import 'dart:io';
import 'package:ciclar_mobile/utils/names_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CoreDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDataBase();
    return _database!;
  }

  createDataBase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "ciclar.db");

    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (e) {
      print("can't create databases path");
    }

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE ${NameTable.postPlaceHolder}(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, body TEXT, createAt INTEGER, FOREIGN KEY(id) REFERENCES ${NameTable.postPlaceHolder}(id) ON DELETE CASCADE)',
    );
  }
}
