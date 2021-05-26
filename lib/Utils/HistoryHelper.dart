import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zmongol/Model/CustomizableText.dart';
import 'package:zmongol/Model/HistoryImage.dart';
import 'package:zmongol/Model/MongolTextBoxStyle.dart';

const String IMAGE_TABLE = 'images';
const String CUSTOM_TEXT_TABLE = 'customizableText';
const String STYLE_TABLE = 'style';

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
          'CREATE TABLE $IMAGE_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT, filePath TEXT, previewFilePath TEXT, dateTime TEXT)'
        );
        db.execute(
            'CREATE TABLE $CUSTOM_TEXT_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT, imageId INTEGER, text TEXT, dx REAL, dy REAL)'
        );
        db.execute(
            'CREATE TABLE $STYLE_TABLE('
                'id INTEGER PRIMARY KEY AUTOINCREMENT, textId INTEGER, width REAL, height REAL,'
                'backgroundColor TEXT, fontSize REAL, textColor TEXT, fontFamily TEXT, shadowColor TEXT, borderColor TEXT)'
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

  insertTextStyle(MongolTextBoxStyle mongolTextBoxStyle) async {
    await db.insert(
      STYLE_TABLE,
      mongolTextBoxStyle.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  deleteImage(HistoryImage historyImage) async {
    List<CustomizableText> texts = await HistoryHelper.instance.getTextsByImageId(historyImage.id!);
    int rs = await db.delete(IMAGE_TABLE, where: 'id = ${historyImage.id}');
    if (rs > 0) {
      if (historyImage.filePath != null) {
        File imageFile = File(historyImage.filePath!);
        imageFile.delete();
      }
      if (historyImage.previewFilePath != null) {
        File previewImageFile = File(historyImage.previewFilePath!);
        previewImageFile.delete();
      }
    }

    texts.forEach((element) {
      db.delete(STYLE_TABLE, where: 'textId = ${element.id}');
      db.delete(CUSTOM_TEXT_TABLE, where: 'id = ${element.id}');
    });
  }

  Future<List<HistoryImage>> getImages() async {
    final List<Map<String, dynamic>> maps = await db.query(IMAGE_TABLE, orderBy: 'dateTime DESC');
    return List.generate(maps.length, (i) {
      return HistoryImage(
        id: maps[i]['id'],
        filePath: maps[i]['filePath'] ?? '',
        previewFilePath: maps[i]['previewFilePath'],
        dateTime: maps[i]['dateTime'],
      );
    });
  }

  Future<List<CustomizableText>> getTextsByImageId(int imageId) async {
    final List<Map<String, dynamic>> maps = await db.query(CUSTOM_TEXT_TABLE, where: 'imageId == $imageId');
    return List.generate(maps.length, (i) {
      return CustomizableText(
          id: maps[i]['id'],
          tag: DateTime.now().microsecondsSinceEpoch.toString(),
          text: maps[i]['text'],
          editable: false,
          dx: maps[i]['dx'],
          dy: maps[i]['dy'],
          isHistoryItem: 1
      );
    });
  }

  Future<MongolTextBoxStyle?> getMongolTextBoxStyleByTextId(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(STYLE_TABLE, where: 'textId == $id');
    if (maps.isEmpty) {
      return null;
    }

    return MongolTextBoxStyle(
        id: maps[0]['id'],
        textId: maps[0]['textId'],
        width: maps[0]['width'],
        height: maps[0]['height'],
        backgroundColor: maps[0]['backgroundColor'],
        fontSize: maps[0]['fontSize'],
        textColor: maps[0]['textColor'],
        fontFamily: maps[0]['fontFamily'],
        shadowColor: maps[0]['shadowColor'],
        borderColor: maps[0]['borderColor']
    );
  }

  saveToHistory(String fileExtension, Uint8List? imageData, Uint8List? previewImageData, List<CustomizableText> texts) async {
    // NOTE: max 50 images in history
    int c = await count();
    if (c >= 50) {
      return;
    }

    HistoryImage historyImage = new HistoryImage(dateTime: DateTime.now().toString());

    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    if (imageData != null) {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      String filePath = '$appDocumentsPath/$fileName$fileExtension';
      File file = File(filePath);
      file.writeAsBytesSync(imageData);
      historyImage.filePath = filePath;
    }

    if (previewImageData != null) {
      // NOTE: preview file
      String previewFileName = 'preview_' +DateTime.now().microsecondsSinceEpoch.toString();
      String previewFilePath = '$appDocumentsPath/$previewFileName$fileExtension';
      File previewFile = File(previewFilePath);
      previewFile.writeAsBytesSync(previewImageData);
      historyImage.previewFilePath = previewFilePath;
    }

    int imageId = await insertImage(historyImage);
    texts.forEach((text) async {
      text.setImageId(imageId);
      int textId = await insertCustomizableText(text);
      text.setId(textId);
      MongolTextBoxStyle mongolTextBoxStyle = MongolTextBoxStyle.getMongolTextBoxStyle(text);
      insertTextStyle(mongolTextBoxStyle);
    });
  }

  count() async {
    final List<Map<String, dynamic>> rs = await db.rawQuery('SELECT COUNT(*) FROM $IMAGE_TABLE');
    return rs[0]['COUNT(*)'];
  }
}