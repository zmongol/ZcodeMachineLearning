import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  final sqlFileName = 'z52words03.db';
  // final sqlFileName = 'words52_20200821.db';

  late Database db;
  String path = '';
  open() async {
    var dbPath = await getDatabasesPath();
    path = join(dbPath, sqlFileName);

    db = await openDatabase('assets/$sqlFileName');

    // Check if the database exists
    bool exists = await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", sqlFileName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    db = await openDatabase(path, readOnly: true);
    print('now db is open');
    //path = await getDatabasesPath().toString() + sqlFileName;
    // if (db == null) {
    //   db = await openDatabase(path, version: 1, onCreate: (db, ver) {
    //     db.execute('''
    //     Create Table word(
    //     ID INTEGER PRIMARY KEY,
    //     MONGOL TEXT,
    //     ACTIVE INTEGER
    //     LATIN_LENGTH INTEGER
    //     LATIN TEXT
    //     PHRASE TEXT
    //     )
    //     ''');
    //   });
    // }
  }

  // Future insert(Map<String, String> m) async {
  //   return await db.insert(table, m);
  // }

  Future queryAll(table) async {
    return await db.query(table, columns: null);
  }

  Future queryWords(String table, String latin) async {
    List<Map<String, dynamic>> list = await db.query(
      table,
      orderBy: 'wlen',
      where: "latin LIKE ? ",
      whereArgs: ['$latin%'],
      limit: 30,
    );
    //这是老数据库的
    // List<Map<String, dynamic>> list = await db.query(
    //   table,
    //   orderBy: 'LATIN_LENGTH',
    //   where: "LATIN LIKE ? ",
    //   whereArgs: ['$latin%'],
    //   limit: 30,
    // );
    return list;
    // return await db.rawQuery(
    //     "SELECT word FROM $table WHERE latin ORDER BY wlen Like '$latin%'  LIMIT 20"
    //     // "SELECT word FROM $table WHERE latin Like '$latin%' AND wlen >= ${latin.length} ORDER BY wlen asc  LIMIT 20"
    //     );
  }
}
