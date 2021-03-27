import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';

class AnimatedMongolText extends StatelessWidget {
  AnimatedMongolText({required this.text, required this.style});
  final String text;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return MongolText.rich(TextSpan(text: text, style: style, children: [
      TextSpan(
          text: '|',
          style: TextStyle(color: Colors.blue, fontSize: style.fontSize ?? 12))
    ]));
  }
}
