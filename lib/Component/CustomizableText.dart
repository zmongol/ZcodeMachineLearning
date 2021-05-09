
class CustomizableText {
  String id;
  String text;
  bool editable;
  double dx;
  double dy;

  CustomizableText({
    required this.id,
    required this.text,
    required this.editable,
    this.dx = 16.0,
    this.dy = 16.0
  });
}