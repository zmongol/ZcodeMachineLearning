import 'dart:typed_data';

class HistoryImage {
  int? id;
  String filePath;
  String? previewFilePath;
  String dateTime;

  HistoryImage({
    this.id,
    required this.filePath,
    this.previewFilePath,
    required this.dateTime
  });

  setId(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return {
      'filePath': filePath,
      'previewFilePath': previewFilePath,
      'dateTime': dateTime
    };
  }

  @override
  String toString() {
    return 'HistoryImage{id: $id, filePath: $filePath, dateTime: $dateTime}';
  }
}