import 'dart:async';

import 'package:flutter/material.dart';

class KeyBackspace extends StatelessWidget {
  KeyBackspace(this.function);
  final Function function;
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    Timer? timer;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.003 * sw),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        elevation: 0,
        child: Container(
          width: 0.13 * sw,
          height: 0.065 * sh,
          child: GestureDetector(
            child: Container(
              child: Center(
                child: Icon(
                  Icons.keyboard_backspace_sharp,
                  color: IconTheme.of(context).color,
                ),
              ),
            ),
            onTap: () {
              function();
            },
            onLongPress: () {
              timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
                function();
              });
            },
            onLongPressEnd: (d) {
              print("手势取消 ${d.velocity.pixelsPerSecond}");
              if (timer != null) {
                timer!.cancel();
              }
            },
          ),
        ),
      ),
    );
  }
}
