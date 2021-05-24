import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zmongol/Component/CustomizableText.dart';
import 'package:zmongol/Component/HistoryImage.dart';

const String IMAGE_TABLE = 'images';
const String CUSTOM_TEXT_TABLE = 'customizableText';

class HistoryHelper {
  final dbName = 'history.db';
  late Database db;
  String path = '';

  HistoryHelper._privateConstructor();
  static final HistoryHelper _historyHelper = HistoryHelper._privateConstructor();
  static HistoryHelper get instance { return _historyHelper; }

  open() async {
    db = await openDatabase(
      join(await getDatabasesPath(), dbName),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        db.execute(
          'CREATE TABLE $IMAGE_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT, filePath TEXT, dateTime TEXT)'
        );
        db.execute(
            'CREATE TABLE $CUSTOM_TEXT_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT, imageId INTEGER, tag TEXT, text TEXT, dx REAL, dy REAL)'
        );
      },
      version: 1,
    );
    print('History db is opened');
  }

  Future<int> insertImage(HistoryImage historyImage) async {
    return await db.insert(
      IMAGE_TABLE,
      historyImage.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertCustomizableText(CustomizableText customizableText) async {
    return await db.insert(
      CUSTOM_TEXT_TABLE,
      customizableText.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<HistoryImage>> getImages() async {
    final List<Map<String, dynamic>> maps = await db.query(IMAGE_TABLE, orderBy: 'dateTime DESC');
    return List.generate(maps.length, (i) {
      return HistoryImage(
        id: maps[i]['id'],
        filePath: maps[i]['filePath'] ?? '',
        dateTime: maps[i]['dateTime'],
      );
    });
  }

  saveToHistory(String fileExtension, Uint8List imageData, List<CustomizableText> texts) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String filePath = '$appDocumentsPath/$fileName$fileExtension';
    File file = File(filePath);
    file.writeAsBytesSync(imageData);

    HistoryImage historyImage = new HistoryImage(filePath: filePath, dateTime: DateTime.now().toString());
    try {
      int imageId = await insertImage(historyImage);
      texts.forEach((text) {
        text.setImageId(imageId);
        insertCustomizableText(text);
      });
    } catch (error) {
      print('An error has occurred: ${error.toString()}');
    }
  }
}