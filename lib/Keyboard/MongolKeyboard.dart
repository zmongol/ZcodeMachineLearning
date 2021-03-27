import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Controller/KeyboardController.dart';
import 'package:zmongol/Keyboard/KbEnglish.dart';
import 'package:zmongol/Keyboard/KbMongol.dart';
import 'package:zmongol/Keyboard/KbSymbol.dart';

class MongolKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    //print('keyboard height:${mediaQuery.size.height / 2.8}');
    //键盘的具体内容

    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: DefaultTextStyle(
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 23.0),
          child: Container(
            height: mediaQuery.size.height / 3.4,
            width: mediaQuery.size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: GetBuilder<KeyboardController>(
              id: 'kb',
              builder: (ctr) {
                if (ctr.typeIndex == 0) {
                  return KBMongol();
                } else if (ctr.typeIndex == 1) {
                  return KBEnglish();
                } else {
                  return KBSymbol();
                }
              },
            ),
          )),
    );
  }
}
