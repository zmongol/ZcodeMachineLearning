import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_state_manager/src/simple/get_state.dart';

class StyleController extends GetxController {
  var _backgroundColor = Colors.transparent.obs;
  Color get backgroundColor => _backgroundColor.value;

  var width = 250.0.obs;
  var height = 280.0.obs;

  copyValueFrom(String tag) {
    final sourceController = Get.find<StyleController>(tag: tag);
    width.value = sourceController.width.value;
    height.value = sourceController.height.value;
    setBackgroundColor(sourceController.backgroundColor);
  }

  setBackgroundColor(Color color) {
    _backgroundColor.value = color;
  }
}
