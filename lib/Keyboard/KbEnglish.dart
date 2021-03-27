import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Controller/KeyboardController.dart';
import 'package:zmongol/Keyboard/KeyBackspace.dart';
import 'package:zmongol/Keyboard/KeyEnglish.dart';
import 'package:zmongol/Keyboard/KeySpacebar.dart';

import 'KeyAction.dart';
import 'KeyActionNormal.dart';
import 'KeySymbol.dart';

class KBEnglish extends StatelessWidget {
  final KeyboardController kbCtr = Get.find<KeyboardController>();
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Container(
      width: sw,
      height: 0.07 * 3 * sh,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          // Obx(() => Text(kbCtr.latin.value)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyEnglish('q'),
                    KeyEnglish('w'),
                    KeyEnglish('e'),
                    KeyEnglish('r'),
                    KeyEnglish('t'),
                    KeyEnglish('y'),
                    KeyEnglish('u'),
                    KeyEnglish('i'),
                    KeyEnglish('o'),
                    KeyEnglish('p'),
                  ],
                ),
                SizedBox(
                  height: 0.005 * sh,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    KeyEnglish('a'),
                    KeyEnglish('s'),
                    KeyEnglish('d'),
                    KeyEnglish('f'),
                    KeyEnglish('g'),
                    KeyEnglish('h'),
                    KeyEnglish('j'),
                    KeyEnglish('k'),
                    KeyEnglish('l'),
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
                        color: ctr.onShift
                            ? Colors.blue
                            : IconTheme.of(context).color!,
                      ),
                    ),
                    KeyEnglish('z'),
                    KeyEnglish('x'),
                    KeyEnglish('c'),
                    KeyEnglish('v'),
                    KeyEnglish('b'),
                    KeyEnglish('n'),
                    KeyEnglish('m'),
                    GetBuilder<KeyboardController>(
                      builder: (ctr) => KeyBackspace(() {
                        ctr.deleteOne();
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
                          //切换到符号键盘
                          Get.find<KeyboardController>().changeKeyboardType(2);
                        }),
                    KeyActionNormal(
                        icon: Icons.language,
                        function: () {
                          //切换到mongol键盘
                          Get.find<KeyboardController>().changeKeyboardType(0);
                        }),
                    KeySymbol(','),
                    KeySpacebar(),
                    KeySymbol('.'),
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
