
class CustomizableText {
  String? imageId;
  String tag;
  String text;
  bool editable;
  String? copyFromTag;
  double dx;
  double dy;

  CustomizableText({
    this.imageId,
    required this.tag,
    required this.text,
    required this.editable,
    this.copyFromTag,
    this.dx = 16.0,
    this.dy = 16.0
  });

  setImageId(String imageId) {
    this.imageId = imageId;
  }

  Map<String, dynamic> toMap() {
    return {
      'imageId': imageId,
      'tag': tag,
      'text': text,
      'dx': dx,
      'dy': dy
    };
  }

  @override
  String toString() {
    return 'CustomizableText{imageId: $imageId, tag: $tag, text: $text, dx: $dx, dy: $dy}';
  }
}