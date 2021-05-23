
class CustomizableText {
  String tag;
  String text;
  bool editable;
  String? copyFromTag;
  double dx;
  double dy;

  CustomizableText({
    required this.tag,
    required this.text,
    required this.editable,
    this.copyFromTag,
    this.dx = 16.0,
    this.dy = 16.0
  });
}