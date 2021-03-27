import 'package:flutter/material.dart';

class KeyActionNormal extends StatelessWidget {
  /// At least one of [text], [icon] must be non-null. The [function]must be non-null.
  /// The [icon] and [lable] arguments must not be used at the same time.
  KeyActionNormal(
      {Key? key, this.icon, this.text, required this.function, this.rotate})
      : assert(function != null),
        assert(icon == null || text == null),
        // assert(icon != null || lable != null),
        super(key: key);
  final IconData? icon;
  final String? text;
  final Function function;
  final bool? rotate;

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
                child: text == null
                    ? Icon(
                        icon,
                      )
                    : RotatedBox(
                        quarterTurns: rotate != null && rotate == true ? 1 : 0,
                        child: Text(
                          text!,
                          style: TextStyle(fontSize: 12),
                        ),
                      )),
          ),
          onPressed: () {
            function();
          },
        ),
      ),
    );
  }
}
