
class CustomizableText {
  String id;
  String text;
  bool editAble;
  double dx;
  double dy;

  CustomizableText({
    required this.id,
    required this.text,
    required this.editAble,
    this.dx = 16.0,
    this.dy = 16.0
  });
}