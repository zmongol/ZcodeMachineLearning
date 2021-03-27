import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Controller/KeyboardController.dart';

import 'KeyAction.dart';
import 'KeyActionNormal.dart';
import 'KeyBackspace.dart';
import 'KeyEnglish.dart';
import 'KeySpacebar.dart';
import 'KeySymbol.dart';

class KBSymbol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Container(
      width: sw,
      height: 0.06 * 3 * sh,
      color: Colors.grey.shade100,
      child: GetBuilder<KeyboardController>(
        id: 'shift',
        builder: (ctr) {
          return Column(
            children: <Widget>[
              // Text(ctr.latin.value),
              Expanded(
                child: ctr.onShift
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              KeySymbol('['),
                              KeySymbol(']'),
                              KeySymbol('{'),
                              KeySymbol('}'),
                              KeySymbol('#'),
                              KeySymbol('%'),
                              KeySymbol('^'),
                              KeySymbol('*'),
                              KeySymbol('+'),
                              KeySymbol('='),
                            ],
                          ),
                          SizedBox(
                            height: 0.005 * sh,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              KeySymbol('-'),
                              KeySymbol('/'),
                              KeySymbol(':'),
                              KeySymbol(';'),
                              KeySymbol('('),
                              KeySymbol(')'),
                              KeySymbol('￥'),
                              KeySymbol('@'),
                              KeySymbol('&'),
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
                                  text: '123',
                                  function: () {
                                    ctr.changeShiftState();
                                  },
                                  color: ctr.onShift ? Colors.blue : null,
                                ),
                              ),
                              KeySymbol('"'),
                              KeySymbol('.'),
                              KeySymbol(','),
                              KeySymbol('?'),
                              KeySymbol('!'),
                              KeySymbol("'"),
                              KeySymbol('_'),
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
                                  text: 'MN',
                                  function: () {
                                    //切换到符号键盘
                                    Get.find<KeyboardController>()
                                        .setShift(false);
                                    Get.find<KeyboardController>()
                                        .changeKeyboardType(0);
                                  }),
                              KeyActionNormal(
                                  icon: Icons.language,
                                  function: () {
                                    //切换到mongol键盘
                                    Get.find<KeyboardController>()
                                        .setShift(false);
                                    Get.find<KeyboardController>()
                                        .changeKeyboardType(0);
                                  }),
                              KeySymbol(
                                ',',
                              ),
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
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              KeyEnglish('1'),
                              KeyEnglish('2'),
                              KeyEnglish('3'),
                              KeyEnglish('4'),
                              KeyEnglish('5'),
                              KeyEnglish('6'),
                              KeyEnglish('7'),
                              KeyEnglish('8'),
                              KeyEnglish('9'),
                              KeyEnglish('0'),
                            ],
                          ),
                          SizedBox(
                            height: 0.005 * sh,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              KeySymbol('ᡣ'),
                              KeySymbol('ᡐ'),
                              KeySymbol('ᡑ'),
                              KeySymbol('ᡕ'),
                              KeySymbol('ᡖ'),
                              KeySymbol('᠁'),
                              KeySymbol('ᡗ'),
                              KeySymbol('ᡘ'),
                              KeySymbol('ᡏ'),
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
                                  text: '#+=',
                                  function: () {
                                    ctr.changeShiftState();
                                  },
                                  color: ctr.onShift ? Colors.blue : null,
                                ),
                              ),
                              KeySymbol('᠄'),
                              KeySymbol('ᡛ'),
                              KeySymbol('ᡜ'),
                              KeySymbol('ᡓ'),
                              KeySymbol('ᡒ'),
                              KeySymbol('ᡙ'),
                              KeySymbol('ᡚ'),
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
                                  text: 'MN',
                                  function: () {
                                    //切换到符号键盘
                                    Get.find<KeyboardController>()
                                        .changeKeyboardType(0);
                                  }),
                              KeyActionNormal(
                                  icon: Icons.language,
                                  function: () {
                                    //切换到mongol键盘
                                    Get.find<KeyboardController>()
                                        .changeKeyboardType(0);
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
          );
        },
      ),
    );
  }
}
