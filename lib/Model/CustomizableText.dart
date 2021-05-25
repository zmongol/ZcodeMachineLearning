
class CustomizableText {
  int? id;
  int? imageId;
  String tag;
  String text;
  bool editable;
  String? copyFromTag;
  double dx;
  double dy;
  int isHistoryItem;

  CustomizableText({
    this.id,
    this.imageId,
    required this.tag,
    required this.text,
    required this.editable,
    this.copyFromTag,
    this.dx = 16.0,
    this.dy = 16.0,
    this.isHistoryItem = 0
  });

  setImageId(int imageId) {
    this.imageId = imageId;
  }

  setId(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return {
      'imageId': imageId,
      'text': text,
      'dx': dx,
      'dy': dy
    };
  }

  @override
  String toString() {
    return 'CustomizableText{id: $id, imageId: $imageId, tag: $tag, text: $text, dx: $dx, dy: $dy, isHistoryItem: $isHistoryItem}';
  }
}