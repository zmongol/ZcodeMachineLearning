import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongol/mongol.dart';
import 'package:zmongol/Controller/TextController.dart';

import 'MongolFonts.dart';

class FontsPicker {
  fontSize() {
    Get.bottomSheet(StatefulBuilder(
      builder: (context, setState) => Container(
          color: Colors.white,
          width: Get.mediaQuery.size.width,
          height: 100,
          child: GetBuilder<TextStyleController>(builder: (ctr) {
            print('value : ${ctr.style.fontSize}');
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'font size:' + ctr.style.fontSize.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  Slider(
                    value:
                        ctr.style.fontSize == null ? 44 : ctr.style.fontSize!,
                    onChanged: (data) {
                      print('change:$data');

                      ctr.setFontSize(data);
                    },
                    onChangeStart: (data) {
                      print('start:$data');
                    },
                    onChangeEnd: (data) {
                      print('end:$data');
                    },
                    min: 10.0,
                    max: 100.0,
                    divisions: 45,
                    label: '${ctr.style.fontSize}',
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.grey,
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()} }';
                    },
                  ),
                ],
              ),
            );
          })),
    ));
  }

  fontFamily() {
    Get.bottomSheet(Container(
      color: Colors.white,
      height: 260,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 48,
          itemCount: MongolFonts.fontList.length,
          itemBuilder: (context, int i) {
            return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    onTap: () {
                      Get.find<TextStyleController>()
                          .setFontFamily(MongolFonts.fontList[i][0]);
                      Get.back();
                    },
                    child: MongolText(
                      MongolFonts.fontList[i][1],
                      style: TextStyle(
                          fontSize: 28, fontFamily: MongolFonts.fontList[i][0]),
                    ),
                  ),
                ));
          }),
    ));
  }

  shadowSetting() {
    Get.bottomSheet(StatefulBuilder(
      builder: (context, setState) => Container(
          color: Colors.white,
          width: Get.mediaQuery.size.width,
          height: 100,
          child: GetBuilder<TextStyleController>(builder: (ctr) {
            print('value : ${ctr.style.fontSize}');
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ctr.style.fontSize.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  Slider(
                    value:
                        ctr.style.fontSize == null ? 44 : ctr.style.fontSize!,
                    onChanged: (data) {
                      print('change:$data');

                      ctr.setFontSize(data);
                    },
                    onChangeStart: (data) {
                      print('start:$data');
                    },
                    onChangeEnd: (data) {
                      print('end:$data');
                    },
                    min: 10.0,
                    max: 100.0,
                    divisions: 45,
                    label: '${ctr.style.fontSize}',
                    activeColor: Colors.deepPurple,
                    inactiveColor: Colors.grey,
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()} }';
                    },
                  ),
                ],
              ),
            );
          })),
    ));
  }
}
