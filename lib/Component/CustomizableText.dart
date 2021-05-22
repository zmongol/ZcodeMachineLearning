
class CustomizableText {
  String id;
  String text;
  bool editable;
  String? copyFromId;
  double dx;
  double dy;

  CustomizableText({
    required this.id,
    required this.text,
    required this.editable,
    this.copyFromId,
    this.dx = 16.0,
    this.dy = 16.0
  });
}