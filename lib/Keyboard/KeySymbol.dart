import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Controller/KeyboardController.dart';

class KeySymbol extends StatelessWidget {
  KeySymbol(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.003 * sw),
      child: Container(
        width: 0.092 * sw,
        height: 0.065 * sh,
        child: RawMaterialButton(
          fillColor: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          elevation: 0,
          child: Container(
            child: Center(
                child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            )),
          ),
          onPressed: () {
            Get.find<KeyboardController>().addText(text + ' ');
          },
        ),
      ),
    );
  }
}
