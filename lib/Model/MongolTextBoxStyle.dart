import 'package:zmongol/Model/CustomizableText.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'package:zmongol/Controller/TextController.dart';
import 'package:get/get.dart';

class MongolTextBoxStyle {
  int? id;
  int? textId;
  double width;
  double height;
  String backgroundColor;
  double fontSize;
  String textColor;
  String fontFamily;
  String shadowColor;
  String borderColor;

  MongolTextBoxStyle({
    this.id,
    required this.textId,
    this.width = 250,
    this.height = 280,
    this.backgroundColor = '00000000', // NOTE: transparent color
    this.fontSize = 26,
    this.textColor = 'FF000000',
    this.fontFamily = 'haratig',
    this.shadowColor = '00000000',
    this.borderColor = '00000000'
  });

  Map<String, dynamic> toMap() {
    return {
      'textId': textId,
      'width': width,
      'height': height,
      'backgroundColor': backgroundColor,
      'fontSize': fontSize,
      'textColor': textColor,
      'fontFamily': fontFamily,
      'shadowColor': shadowColor,
      'borderColor': borderColor
    };
  }

  static MongolTextBoxStyle getMongolTextBoxStyle(CustomizableText text) {
    final TextStyleController textController = Get.find<TextStyleController>(tag: text.tag);
    final TextStyleController borderController = Get.find<TextStyleController>(tag: 'border_style_' + text.tag);
    final StyleController styleController = Get.find<StyleController>(tag: text.tag);
    return MongolTextBoxStyle(
        textId: text.id,
        width: styleController.width.value,
        height: styleController.height.value,
        backgroundColor: styleController.backgroundColor.value.toRadixString(16),
        fontSize: textController.style.fontSize!,
        textColor: textController.style.color!.value.toRadixString(16),
        fontFamily: textController.style.fontFamily!,
        shadowColor: textController.style.shadows![0].color.value.toRadixString(16),
        borderColor: borderController.borderStyle.foreground!.color.value.toRadixString(16)
    );
  }
}