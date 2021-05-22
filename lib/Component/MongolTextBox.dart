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
  final Function onCopyButtonPressed;
  final Function onEditButtonPressed;

  MongolTextBox(
      this.customizableText,
      {
        required this.onTextBoxTapped,
        required this.onTextBoxDeleted,
        required this.onCopyButtonPressed,
        required this.onEditButtonPressed
      }
  );

  @override
  Widget build(BuildContext context) {
    final textController = Get.put<TextStyleController>(TextStyleController(), tag: customizableText.id);
    final borderController = Get.put<TextStyleController>(TextStyleController(), tag: 'border_style_' + customizableText.id);
    final styleController = Get.put<StyleController>(StyleController(), tag: customizableText.id);

    if (customizableText.copyFromId != null) {
      textController.copyValueFrom(customizableText.copyFromId!);
      borderController.copyValueFrom(customizableText.copyFromId!);
      styleController.copyValueFrom(customizableText.copyFromId!);
      customizableText.copyFromId = null;
    }
    return Positioned(
        top: customizableText.dy,
        left: customizableText.dx,
        child: Obx(
                () =>  GestureDetector(
                    onPanUpdate: (DragUpdateDetails d) {
                      onTextBoxTapped();
                      if (customizableText.editable == false) {
                        customizableText.editable = true;
                      }
                      customizableText.dx += d.delta.dx;
                      customizableText.dy += d.delta.dy;
                    },
                    child: DragToResizeBox(
                        width: styleController.width.value,
                        height: styleController.height.value,
                        editable: customizableText.editable,
                        deletable: true,
                        onTextBoxDeleted: onTextBoxDeleted,
                        onWidthChange: (v) {
                          styleController.width.value += v;
                        },
                        onHeightChange: (v) {
                          styleController.height.value += v;
                        },
                        onCopyButtonPressed: onCopyButtonPressed,
                        onEditButtonPressed: onEditButtonPressed,
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
                                        style: borderController.borderStyle.copyWith(fontSize: 200)
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 16),
                                      child: AutoSizeText(
                                          customizableText.text,
                                          minFontSize: 20,
                                          maxFontSize: 200,
                                          style: textController.style.copyWith(fontSize: 200)
                                      )
                                  )
                                ]
                            )
                        )
                    )
                )
        )
    );
  }
}
