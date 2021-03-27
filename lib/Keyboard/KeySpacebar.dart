import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Controller/KeyboardController.dart';

class KeySpacebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.003 * sw),
      child: Container(
        width: 0.39 * sw,
        height: 0.065 * sh,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: RawMaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          fillColor: Colors.white,
          child: Container(
            child: Center(
              child: Icon(Icons.space_bar),
            ),
          ),
          onPressed: () {
            Get.find<KeyboardController>().addText(' ');
          },
        ),
      ),
    );
  }
}
