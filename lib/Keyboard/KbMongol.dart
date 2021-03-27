import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Controller/KeyboardController.dart';
import 'package:zmongol/Keyboard/KeyBackspace.dart';
import 'package:zmongol/Keyboard/KeySpacebar.dart';

import 'KeyAction.dart';
import 'KeyActionNormal.dart';
import 'KeyMongol.dart';
import 'KeySymbol.dart';

class KBMongol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Container(
      width: sw,
      height: 0.05 * 3 * sh,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          // GetBuilder<KeyboardController>(
          //     id: 'latin', builder: (ctr) => Obx(() => Text(ctr.latin.value))),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyMongol(title: 'q', mglChar: 'ᢚ', mglShiftChar: 'ᢦ'),
                    KeyMongol(title: 'w', mglChar: 'ᢟ'),
                    KeyMongol(title: 'e', mglChar: 'ᡥᡨ', mglShiftChar: 'ᢟ'),
                    KeyMongol(title: 'r', mglChar: 'ᢞ'),
                    KeyMongol(title: 't', mglChar: 'ᢘ', mglShiftChar: 'ᢙ'),
                    KeyMongol(title: 'y', mglChar: 'ᢜ'),
                    KeyMongol(title: 'u', mglChar: 'ᡥᡭᡬ', mglShiftChar: 'ᡭᡬ'),
                    KeyMongol(title: 'i', mglChar: 'ᡥᡫ'),
                    KeyMongol(title: 'o', mglChar: 'ᡥᡭ', mglShiftChar: 'ᡭ'),
                    KeyMongol(title: 'p', mglChar: 'ᡶ'),
                  ],
                ),
                SizedBox(
                  height: 0.005 * sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyMongol(title: 'a', mglChar: 'ᡥᡧ'),
                    KeyMongol(title: 's', mglChar: 'ᢔᡮ'),
                    KeyMongol(title: 'd', mglChar: 'ᢙ', mglShiftChar: 'ᢘ'),
                    KeyMongol(title: 'f', mglChar: 'ᢡ'),
                    KeyMongol(title: 'g', mglChar: 'ᢈ'),
                    KeyMongol(title: 'h', mglChar: 'ᡸ'),
                    KeyMongol(title: 'j', mglChar: 'ᡬ'),
                    KeyMongol(title: 'k', mglChar: 'ᢤ'),
                    KeyMongol(title: 'l', mglChar: 'ᢏ', mglShiftChar: 'ᢏᢨ'),
                  ],
                ),
                SizedBox(
                  height: 0.005 * sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GetBuilder<KeyboardController>(
                      id: 'shift',
                      builder: (ctr) => KeyAction(
                        icon: Icons.file_upload,
                        function: () {
                          ctr.changeShiftState();
                        },
                        color: ctr.onShift ? Colors.blue : null,
                      ),
                    ),
                    KeyMongol(title: 'z', mglChar: 'ᢧ', mglShiftChar: 'ᢨ'),
                    KeyMongol(title: 'x', mglChar: 'ᢗᡮ'),
                    KeyMongol(title: 'c', mglChar: 'ᢚ', mglShiftChar: 'ᢦ'),
                    KeyMongol(title: 'v', mglChar: 'ᡥᡭ', mglShiftChar: 'ᡭ'),
                    KeyMongol(title: 'b', mglChar: 'ᡳ'),
                    KeyMongol(title: 'n', mglChar: 'ᡯ'),
                    KeyMongol(title: 'm', mglChar: 'ᢌ'),
                    GetBuilder<KeyboardController>(
                      builder: (ctr) => KeyBackspace(() {
                        if (ctr.latin.value.isNotEmpty) {
                          ctr.setLatin(
                              ctr.latin.substring(
                                0,
                                ctr.latin.value.length - 1,
                              ),
                              isMongol: true);
                        } else {
                          ctr.deleteOne();
                        }
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.005 * sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyAction(
                        text: '123',
                        function: () {
                          Get.find<KeyboardController>().changeKeyboardType(2);
                        }),
                    KeyActionNormal(
                        icon: Icons.language,
                        function: () {
                          Get.find<KeyboardController>().changeKeyboardType(1);
                        }),
                    KeySymbol(
                      '᠂',
                    ),
                    KeySpacebar(),
                    KeySymbol('᠃'),
                    GetBuilder<KeyboardController>(
                      id: 'latin',
                      builder: (ctr) => KeyAction(
                          icon: Icons.keyboard_return,
                          function: () {
                            ctr.latin.isNotEmpty
                                ? ctr.enterAction(null)
                                : ctr.addText('\n');
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.01 * sh,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
