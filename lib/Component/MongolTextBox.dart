import 'package:flutter/cupertino.dart';
import 'package:zmongol/Component/CustomizableText.dart';
import 'package:zmongol/Controller/TextController.dart';
import 'package:get/get.dart';
import 'package:zmongol/Component/AutoSizeText/auto_size_text.dart';
import 'package:zmongol/Component/DragToResizeBox.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'DragToResizeBox.dart';

class MongolTextBox extends StatelessWidget {
  final CustomizableText customizableText;
  final Function onTextBoxTapped;
  final Function onTextBoxDeleted;

  MongolTextBox(this.customizableText,
      {required this.onTextBoxTapped, required this.onTextBoxDeleted});

  @override
  Widget build(BuildContext context) {
    final textController = Get.put<TextStyleController>(TextStyleController(),
        tag: customizableText.id);
    final boderController = Get.put<TextStyleController>(TextStyleController(),
        tag: 'border_style_' + customizableText.id);
    final styleController =
        Get.put<StyleController>(StyleController(), tag: customizableText.id);
    return Stack(children: [
      Positioned(
        top: customizableText.dy,
        left: customizableText.dx,
        child: Obx(
          () => GestureDetector(
            onPanUpdate: (DragUpdateDetails d) {
              onTextBoxTapped();
              if (customizableText.editable == false) {
                customizableText.editable = true;
              }
              customizableText.dx += d.delta.dx;
              customizableText.dy += d.delta.dy;
              // print('onPanUpdate dx:$dx');
              // print('onPanUpdate dy:$dy');
            },
            child: DragToResizeBox(
              width: styleController.width.value,
              height: styleController.height.value,
              editable: customizableText.editable,
              //NOTE: disable deletable option as there is an error of styling text when deleting
              deletable: true,
              // deletable: false,
              onTextBoxDeleted: onTextBoxDeleted,
              onWidthChange: (v) {
                styleController.width.value += v;
              },
              onHeightChange: (v) {
                styleController.height.value += v;
              },
              child: Container(
                width: styleController.width.value,
                height: styleController.height.value,
                color: styleController.backgroundColor,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: AutoSizeText(
                        customizableText.text,
                        minFontSize: 20,
                        maxFontSize: 200,
                        style:
                            boderController.borderStyle.copyWith(fontSize: 200),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: AutoSizeText(customizableText.text,
                          minFontSize: 20,
                          maxFontSize: 200,
                          style: textController.style.copyWith(
                            fontSize: 200,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
