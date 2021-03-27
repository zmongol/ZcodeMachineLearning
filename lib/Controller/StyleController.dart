import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_state_manager/src/simple/get_state.dart';

class StyleController extends GetxController {
  Color _backgroundColor = Colors.transparent;
  Color get backgroundColor => _backgroundColor;

  var width = 250.0.obs;
  var height = 280.0.obs;

  setBackgroundColor(Color color) {
    _backgroundColor = color;
    update();
  }
}
