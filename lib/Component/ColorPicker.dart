import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'package:zmongol/Controller/TextController.dart';

class ColorPicker {
  void font() {
    Get.dialog(AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      content: SingleChildScrollView(
        child: MaterialPicker(
          pickerColor: Get.find<TextStyleController>().style.color!,
          onColorChanged: (Color color) {
            Get.find<TextStyleController>().setColor(color);
            Get.back();
          },
          enableLabel: true,
        ),
      ),
    ));
  }

  void shadow() {
    Get.dialog(AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      content: SingleChildScrollView(
        child: MaterialPicker(
          pickerColor: Get.find<TextStyleController>().style.shadows![0].color,
          onColorChanged: (Color color) {
            Get.find<TextStyleController>().setShadowColor(color);
            Get.back();
          },
          enableLabel: true,
        ),
      ),
    ));
  }

  borderColor(Color originalColor) async {
    final newBorderColor = await Get.dialog(AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      content: SingleChildScrollView(
        child: MaterialPicker(
          pickerColor: originalColor,
          onColorChanged: (Color color) {
            Get.back(result: color);
          },
          enableLabel: true,
        ),
      ),
    ));
    return newBorderColor;
  }

  void background() {
    Get.dialog(AlertDialog(
      titlePadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      content: SingleChildScrollView(
        child: MaterialPicker(
          pickerColor: Get.find<StyleController>().backgroundColor,
          onColorChanged: (Color color) {
            Get.find<StyleController>().setBackgroundColor(color);
            Get.back();
          },
          enableLabel: true,
        ),
      ),
    ));
  }
}

class MaterialPicker extends StatefulWidget {
  MaterialPicker({
    required this.pickerColor,
    required this.onColorChanged,
    this.enableLabel: false,
  });

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final bool enableLabel;

  @override
  State<StatefulWidget> createState() => _MaterialPickerState();
}

class _MaterialPickerState extends State<MaterialPicker> {
  final List<List<Color>> _colorTypes = [
    [Colors.grey],
    [Colors.blueGrey],
    [Colors.black],
    [Colors.transparent],
    [Colors.red, Colors.redAccent],
    [Colors.pink, Colors.pinkAccent],
    [Colors.purple, Colors.purpleAccent],
    [Colors.deepPurple, Colors.deepPurpleAccent],
    [Colors.indigo, Colors.indigoAccent],
    [Colors.blue, Colors.blueAccent],
    [Colors.lightBlue, Colors.lightBlueAccent],
    [Colors.cyan, Colors.cyanAccent],
    [Colors.teal, Colors.tealAccent],
    [Colors.green, Colors.greenAccent],
    [Colors.lightGreen, Colors.lightGreenAccent],
    [Colors.lime, Colors.limeAccent],
    [Colors.yellow, Colors.yellowAccent],
    [Colors.amber, Colors.amberAccent],
    [Colors.orange, Colors.orangeAccent],
    [Colors.deepOrange, Colors.deepOrangeAccent],
    [Colors.brown],
  ];

  List<Color> _currentColor = [Colors.red, Colors.redAccent];
  late Color _currentShading;

  List<Color> _shadingTypes(List<Color> colors) {
    List<Color> result = [];

    colors.forEach((Color colorType) {
      if (colorType == Colors.grey) {
        result.addAll([
          50,
          100,
          200,
          300,
          350,
          400,
          500,
          600,
          700,
          800,
          850,
          900
        ].map((int shade) {
          return Colors.grey[shade]!;
        }).toList());
      } else if (colorType == Colors.black ||
          colorType == Colors.white ||
          colorType == Colors.transparent) {
        result.addAll([Colors.black, Colors.white, Colors.transparent]);
      } else if (colorType is MaterialAccentColor) {
        result.addAll([100, 200, 400, 700].map((int shade) {
          return colorType[shade]!;
        }).toList());
      } else if (colorType is MaterialColor) {
        result.addAll(
            [50, 100, 200, 300, 400, 500, 600, 700, 800, 900].map((int shade) {
          return colorType[shade]!;
        }).toList());
      } else if (colorType == Colors.transparent) {
        result.addAll([Colors.transparent]);
      } else {
        result.add(Color(0));
      }
    });

    return result;
  }

  @override
  void initState() {
    _colorTypes.forEach((List<Color> _colors) {
      _shadingTypes(_colors).forEach((Color color) {
        if (widget.pickerColor.value == color.value) {
          return setState(() {
            _currentColor = _colors;
            _currentShading = color;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation _orientation = MediaQuery.of(context).orientation;
    bool _isPortrait = _orientation == Orientation.portrait;

    Widget _colorList() {
      return Container(
        width: _isPortrait ? 60.0 : null,
        height: _isPortrait ? null : 60.0,
        decoration: BoxDecoration(
          border: _isPortrait
              ? Border(right: BorderSide(color: Colors.grey[300]!, width: 1.0))
              : Border(top: BorderSide(color: Colors.grey[300]!, width: 1.0)),
        ),
        child: ListView(
          scrollDirection: _isPortrait ? Axis.vertical : Axis.horizontal,
          children: [
            _isPortrait
                ? const Padding(padding: EdgeInsets.only(top: 7.0))
                : const Padding(padding: EdgeInsets.only(left: 7.0)),
            ..._colorTypes.map((List<Color> _colors) {
              Color _colorType = _colors[0];
              return GestureDetector(
                onTap: () => setState(() => _currentColor = _colors),
                child: Container(
                  color: Color(0),
                  padding: _isPortrait
                      ? EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0)
                      : EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                  child: Align(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        color: _colorType,
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: _currentColor == _colors
                            ? [
                                _colorType == Theme.of(context).cardColor
                                    ? BoxShadow(
                                        color: Colors.grey[300]!,
                                        blurRadius: 5.0,
                                      )
                                    : BoxShadow(
                                        color: _colorType,
                                        blurRadius: 5.0,
                                      ),
                              ]
                            : null,
                        border: _colorType == Theme.of(context).cardColor
                            ? Border.all(
                                color: _colorType == Colors.transparent
                                    ? Colors.redAccent
                                    : Colors.grey[300]!,
                                width: 1.0)
                            : null,
                      ),
                      child: _colorType == Colors.transparent
                          ? FractionalTranslation(
                              translation: Offset(-0.1, 0),
                              child: Icon(
                                Icons.do_not_disturb_alt,
                                size: 30,
                                color: Colors.redAccent,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              );
            }),
            _isPortrait
                ? const Padding(padding: EdgeInsets.only(top: 5.0))
                : const Padding(padding: EdgeInsets.only(left: 5.0)),
          ],
        ),
      );
    }

    Widget _shadingList() {
      return ListView(
        scrollDirection: _isPortrait ? Axis.vertical : Axis.horizontal,
        children: [
          _isPortrait
              ? Padding(padding: EdgeInsets.only(top: 15.0))
              : Padding(padding: EdgeInsets.only(left: 15.0)),
          ..._shadingTypes(_currentColor).map((Color _color) {
            return GestureDetector(
              onTap: () {
                setState(() => _currentShading = _color);
                widget.onColorChanged(_currentShading);
              },
              child: Container(
                color: Color(0),
                padding: _isPortrait
                    ? EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0)
                    : EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Align(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isPortrait ? 250.0 : 50.0,
                    height: _isPortrait ? 50.0 : 220.0,
                    decoration: BoxDecoration(
                      color: _color,
                      boxShadow: _currentShading == _color
                          ? [
                              _color == Theme.of(context).cardColor
                                  ? BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 5.0,
                                    )
                                  : BoxShadow(
                                      color: _currentShading,
                                      blurRadius: 5.0,
                                    ),
                            ]
                          : null,
                      border: _color == Theme.of(context).cardColor ||
                              _color == Colors.transparent
                          ? Border.all(color: Colors.grey[300]!, width: 1.0)
                          : null,
                    ),
                    child: (_isPortrait && widget.enableLabel)
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: _color == Colors.transparent
                                ? Text(
                                    'Transparent  ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    '#' +
                                        (_color
                                                .toString()
                                                .replaceFirst('Color(0xff', '')
                                                .replaceFirst(')', ''))
                                            .toUpperCase() +
                                        '  ',
                                    style: TextStyle(
                                      color: useWhiteForeground(_color)
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          )
                        : Container(),
                  ),
                ),
              ),
            );
          }),
          _isPortrait
              ? const Padding(padding: const EdgeInsets.only(top: 15.0))
              : const Padding(padding: const EdgeInsets.only(left: 15.0)),
        ],
      );
    }

    switch (_orientation) {
      case Orientation.portrait:
        return SizedBox(
          height: 500.0,
          width: 350.0,
          child: Row(
            children: <Widget>[
              _colorList(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _shadingList(),
                ),
              ),
            ],
          ),
        );
      case Orientation.landscape:
        return SizedBox(
          width: 500.0,
          height: 300.0,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: _shadingList(),
                ),
              ),
              _colorList(),
            ],
          ),
        );
      default:
        return Container();
    }
  }
}

bool useWhiteForeground(Color color, {double bias: 1.0}) {
  // Old:
  // return 1.05 / (color.computeLuminance() + 0.05) > 4.5;

  // New:
  // bias ??= 1.0;
  int v = sqrt(pow(color.red, 2) * 0.299 +
          pow(color.green, 2) * 0.587 +
          pow(color.blue, 2) * 0.114)
      .round();
  return v < 130 * bias ? true : false;
}

/// reference: https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_HSL
HSLColor hsvToHsl(HSVColor color) {
  double s = 0.0;
  double l = 0.0;
  l = (2 - color.saturation) * color.value / 2;
  if (l != 0) {
    if (l == 1)
      s = 0.0;
    else if (l < 0.5)
      s = color.saturation * color.value / (l * 2);
    else
      s = color.saturation * color.value / (2 - l * 2);
  }
  return HSLColor.fromAHSL(
    color.alpha,
    color.hue,
    s.clamp(0.0, 1.0),
    l.clamp(0.0, 1.0),
  );
}

/// reference: https://en.wikipedia.org/wiki/HSL_and_HSV#HSL_to_HSV
HSVColor hslToHsv(HSLColor color) {
  double s = 0.0;
  double v = 0.0;

  v = color.lightness +
      color.saturation *
          (color.lightness < 0.5 ? color.lightness : 1 - color.lightness);
  if (v != 0) s = 2 - 2 * color.lightness / v;

  return HSVColor.fromAHSV(
    color.alpha,
    color.hue,
    s.clamp(0.0, 1.0),
    v.clamp(0.0, 1.0),
  );
}
