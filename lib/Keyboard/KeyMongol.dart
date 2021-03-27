import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Component/MongolFonts.dart';
import 'package:zmongol/Controller/KeyboardController.dart';

class KeyMongol extends StatelessWidget {
  const KeyMongol(
      {required this.title, required this.mglChar, this.mglShiftChar});
  final String title;
  final String mglChar;
  final String? mglShiftChar;
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.003 * sw),
      child: Container(
        width: 0.092 * sw,
        height: 0.065 * sh,
        // decoration: BoxDecoration(
        //     color: Colors.white, borderRadius: BorderRadius.circular(3)),
        child: GetBuilder<KeyboardController>(
          id: 'kb',
          builder: (controller) => RawMaterialButton(
            fillColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            onPressed: () {
              String value = title;
              if (controller.onShift) {
                value = title.toUpperCase();
              } else {}

              controller.setLatin(controller.latin.value + value,
                  isMongol: true);

              controller.setShift(false);
            },
            child: Container(
                width: 0.088 * sw,
                height: 0.065 * sh,
                child: Stack(
                  children: [
                    Container(
                      child: Center(
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            mglShiftChar != null && controller.onShift
                                ? mglShiftChar!
                                : mglChar,
                            style: TextStyle(
                                fontSize: 24, fontFamily: MongolFonts.haratig),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 3,
                        left: 3,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontFamily: MongolFonts.haratig, fontSize: 12),
                        ))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
