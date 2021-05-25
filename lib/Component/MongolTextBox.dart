import 'package:flutter/cupertino.dart';
import 'package:zmongol/Component/CustomizableText.dart';
import 'package:zmongol/Component/MongolTextBoxStyle.dart';
import 'package:zmongol/Controller/TextController.dart';
import 'package:get/get.dart';
import 'package:zmongol/Component/AutoSizeText/auto_size_text.dart';
import 'package:zmongol/Component/DragToResizeBox.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'package:zmongol/Utils/HistoryHelper.dart';
import 'DragToResizeBox.dart';

class MongolTextBox extends StatefulWidget {
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
  _MongolTextBoxState createState() => _MongolTextBoxState();
}

class _MongolTextBoxState extends State<MongolTextBox> {

  MongolTextBoxStyle? mongolTextBoxStyle;
  late TextStyleController textController;
  late TextStyleController borderController;
  late StyleController styleController;

  initState() {
    super.initState();
  }

  initController() async {
    textController = Get.put<TextStyleController>(TextStyleController(), tag: widget.customizableText.tag);
    borderController = Get.put<TextStyleController>(TextStyleController(), tag: 'border_style_' + widget.customizableText.tag);
    styleController = Get.put<StyleController>(StyleController(), tag: widget.customizableText.tag);

    if (widget.customizableText.isHistoryItem == 1) {
      await getHistoryStyle();
    }

    if (mongolTextBoxStyle != null) {
      textController.setColor(getColorFromString(mongolTextBoxStyle!.textColor));
      textController.setBorderColor(getColorFromString(mongolTextBoxStyle!.borderColor));
      textController.setFontFamily(mongolTextBoxStyle!.fontFamily);
      textController.setShadowColor(getColorFromString(mongolTextBoxStyle!.shadowColor));
      textController.setFontSize(mongolTextBoxStyle!.fontSize);
      borderController.setBorderColor(getColorFromString(mongolTextBoxStyle!.borderColor));
      borderController.setFontFamily(mongolTextBoxStyle!.fontFamily);
      styleController.height.value = mongolTextBoxStyle!.height;
      styleController.width.value = mongolTextBoxStyle!.width;
      styleController.setBackgroundColor(getColorFromString(mongolTextBoxStyle!.backgroundColor));
      mongolTextBoxStyle = null;
      widget.customizableText.isHistoryItem = 0;
    } else if (widget.customizableText.copyFromTag != null) {
      textController.copyValueFrom(widget.customizableText.copyFromTag!);
      borderController.copyValueFrom(widget.customizableText.copyFromTag!);
      styleController.copyValueFrom(widget.customizableText.copyFromTag!);
      widget.customizableText.copyFromTag = null;
    }
  }

  getHistoryStyle() async {
    mongolTextBoxStyle = await HistoryHelper.instance.getMongolTextBoxStyleByTextId(widget.customizableText.id!);
    setState(() {

    });
  }

  Color getColorFromString(String s) {
    return Color(int.parse('0x$s'));
  }

  @override
  Widget build(BuildContext context) {
    initController();
    return Positioned(
        top: widget.customizableText.dy,
        left: widget.customizableText.dx,
        child: Obx(
                () =>  GestureDetector(
                    onPanUpdate: (DragUpdateDetails d) {
                      widget.onTextBoxTapped();
                      if (widget.customizableText.editable == false) {
                        widget.customizableText.editable = true;
                      }
                      widget.customizableText.dx += d.delta.dx;
                      widget.customizableText.dy += d.delta.dy;
                    },
                    child: DragToResizeBox(
                        width: styleController.width.value,
                        height: styleController.height.value,
                        editable: widget.customizableText.editable,
                        deletable: true,
                        onTextBoxDeleted: widget.onTextBoxDeleted,
                        onWidthChange: (v) {
                          styleController.width.value += v;
                        },
                        onHeightChange: (v) {
                          styleController.height.value += v;
                        },
                        onCopyButtonPressed: widget.onCopyButtonPressed,
                        onEditButtonPressed: widget.onEditButtonPressed,
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
                                        widget.customizableText.text,
                                        minFontSize: 20,
                                        maxFontSize: 200,
                                        style: borderController.borderStyle.copyWith(fontSize: 200)
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 16),
                                      child: AutoSizeText(
                                          widget.customizableText.text,
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
