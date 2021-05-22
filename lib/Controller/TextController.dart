import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Component/MongolFonts.dart';
//import 'package:get/get_state_manager/src/simple/get_state.dart';

class TextStyleController extends GetxController {
  var _style = TextStyle(
      fontSize: 26,
      color: Colors.black,
      fontFamily: MongolFonts.haratig,
      shadows: [
        Shadow(offset: Offset.zero, color: Colors.transparent, blurRadius: 0)
      ]).obs;

  var _borderStyle = TextStyle(
      fontSize: 26,
      fontFamily: MongolFonts.haratig,
      shadows: [
        Shadow(offset: Offset.zero, color: Colors.transparent, blurRadius: 0)
      ],
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..color = Colors.transparent
  ).obs;

  TextStyle get style => _style.value;
  TextStyle get borderStyle => _borderStyle.value;

  bool textShadowAble = false;

  copyValueFrom(String tag) {
    _style.value = Get.find<TextStyleController>(tag: tag).style;
    _borderStyle.value = Get.find<TextStyleController>(tag: 'border_style_$tag').borderStyle;
  }

  setFontSize(double value) {
    _style.value = _style.value.copyWith(fontSize: value);
    _borderStyle.value = _borderStyle.value.copyWith(fontSize: value);
    print('update fontsize ${style.fontSize}');
  }

  increaseFontSize() {
    _style.value = _style.value.copyWith(fontSize: _style.value.fontSize! + 2);
    _borderStyle.value = _borderStyle.value.copyWith(fontSize: _style.value.fontSize! + 2);
    print('update fontsize ${style.fontSize}');
  }

  decreaseFontSize() {
    _style.value = _style.value.copyWith(fontSize: _style.value.fontSize! - 2);
    _borderStyle.value = _borderStyle.value.copyWith(fontSize: _style.value.fontSize! - 2);
    print('update fontsize ${style.fontSize}');
  }

  setColor(Color value) {
    _style.value = _style.value.copyWith(color: value);
  }

  setShadowColor(Color value) {
    var shadow = Shadow(color: value, offset: Offset(2, -2), blurRadius: 3);
    _style.value = _style.value.copyWith(shadows: [shadow]);
    _borderStyle.value = _borderStyle.value.copyWith(shadows: [shadow]);
  }

  setBorderColor(Color value) {
   _borderStyle.value = _borderStyle.value.copyWith(
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..color = value,
    );
  }

  setFontFamily(String value) {
    _style.value = _style.value.copyWith(fontFamily: value);
    _borderStyle.value = _borderStyle.value.copyWith(fontFamily: value);
  }

  setTextShadow() {
    textShadowAble = !textShadowAble;
    if (textShadowAble) {
      _style.value = _style.value.copyWith(shadows: [
        Shadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(2, -2),
            blurRadius: 2)
      ]);

      _borderStyle.value = _borderStyle.value.copyWith(shadows: [
        Shadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(2, -2),
            blurRadius: 2)
      ]);
    } else {
      _style.value = _style.value.copyWith(shadows: [
        Shadow(color: Colors.transparent, offset: Offset.zero, blurRadius: 0)
      ]);
      _borderStyle.value = _borderStyle.value.copyWith(shadows: [
        Shadow(color: Colors.transparent, offset: Offset.zero, blurRadius: 0)
      ]);
    }
  }
}
