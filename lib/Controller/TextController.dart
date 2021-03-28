import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Component/MongolFonts.dart';
//import 'package:get/get_state_manager/src/simple/get_state.dart';

class TextStyleController extends GetxController {
  TextStyle _style = TextStyle(
      fontSize: 26,
      color: Colors.black,
      fontFamily: MongolFonts.haratig,
      shadows: [
        Shadow(offset: Offset.zero, color: Colors.transparent, blurRadius: 0)
      ]);
  TextStyle get style => _style;
  bool textShadowAble = false;
  setFontSize(double value) {
    _style = _style.copyWith(fontSize: value);
    print('update fontsize ${style.fontSize}');
    update();
  }

  increaseFontSize() {
    _style = _style.copyWith(fontSize: style.fontSize! + 2);
    print('update fontsize ${style.fontSize}');
    update();
  }

  decreaseFontSize() {
    _style = _style.copyWith(fontSize: style.fontSize! - 2);
    print('update fontsize ${style.fontSize}');
    update();
  }

  setColor(Color value) {
    _style = _style.copyWith(color: value);
    update();
  }

  setShadowColor(Color value) {
    var shadow = Shadow(color: value, offset: Offset(2, -2), blurRadius: 3);
    List<Shadow> currentShadows = [];
    if (_style.shadows != null) {
      currentShadows = _style.shadows!
          .where((element) => element.offset.dx.abs() == 3)
          .toList();
    }
    currentShadows.add(shadow);
    _style = _style.copyWith(shadows: currentShadows);
    update();
  }

  setBorderColor(Color value) {
    List<Shadow> shadows = [
      Shadow(
          // bottomLeft
          offset: Offset(-3, -3),
          color: value,
          blurRadius: 2),
      Shadow(
          // bottomRight
          offset: Offset(3, -3),
          color: value,
          blurRadius: 2),
      Shadow(
          // topRight
          offset: Offset(3, 3),
          color: value,
          blurRadius: 2),
      Shadow(
          // topLeft
          offset: Offset(-3, 3),
          color: value,
          blurRadius: 2),
    ];
    if (_style.shadows != null) {
      _style.shadows!.forEach((element) {
        if (element.offset.dx.abs() == 2) {
          shadows.add(element);
        }
      });
    }
    _style = _style.copyWith(shadows: shadows);
    update();
  }

  setFontFamily(String value) {
    _style = _style.copyWith(fontFamily: value);
    update();
  }

  setTextShadow() {
    textShadowAble = !textShadowAble;
    if (textShadowAble) {
      _style = _style.copyWith(shadows: [
        Shadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(2, -2),
            blurRadius: 2)
      ]);
    } else {
      _style = _style.copyWith(shadows: [
        Shadow(color: Colors.transparent, offset: Offset.zero, blurRadius: 0)
      ]);
    }

    update();
  }
}
