import 'package:flutter/cupertino.dart';
import 'package:zmongol/Component/CustomizableText.dart';
import 'package:zmongol/Controller/TextController.dart';
import 'package:get/get.dart';
import 'package:zmongol/Component/AutoSizeText/auto_size_text.dart';
import 'package:zmongol/Component/DragToResizeBox.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'DragToResizeBox.dart';

typedef void OnTextBoxTapped(String textBoxId);

class MongolTextBox extends StatefulWidget {
  final CustomizableText customizableText;
  final OnTextBoxTapped onTextBoxTapped;

  const MongolTextBox(this.customizableText, {required this.onTextBoxTapped});

  @override
  _MongolTextBoxState createState() => _MongolTextBoxState();
}

class _MongolTextBoxState extends State<MongolTextBox> {

  @override
  void initState() {
    Get.put<TextStyleController>(TextStyleController(), tag: widget.customizableText.id);
    Get.put<TextStyleController>(TextStyleController(), tag: 'border_style_'+ widget.customizableText.id);
    Get.put<StyleController>(StyleController(), tag: widget.customizableText.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: widget.customizableText.dy,
          left: widget.customizableText.dx,
          child: GetBuilder<StyleController>(
            tag: widget.customizableText.id,
            builder: (styleCtr) => GestureDetector(
              onPanUpdate: (DragUpdateDetails d) {
                widget.onTextBoxTapped(widget.customizableText.id);
                if (widget.customizableText.editAble == false) {
                  widget.customizableText.editAble = true;
                }
                setState(() {
                  widget.customizableText.dx += d.delta.dx;
                  widget.customizableText.dy += d.delta.dy;
                });
                // print('onPanUpdate dx:$dx');
                // print('onPanUpdate dy:$dy');
              },
              child: DragToResizBox(
                width: styleCtr.width.value,
                height: styleCtr.height.value,
                editable: widget.customizableText.editAble,
                onWidthChange: (v) {
                  setState(() {
                    styleCtr.width.value += v;
                  });
                },
                onHeightChange: (v) {
                  setState(() {
                    styleCtr.height.value += v;
                  });
                },
                child: Container(
                  width: styleCtr.width.value,
                  height: styleCtr.height.value,
                  color: styleCtr.backgroundColor,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      GetBuilder<TextStyleController>(tag: 'border_style_${widget.customizableText.id}', builder: (borderCtrl) {
                        return Container(
                          padding: EdgeInsets.only(top: 16),
                          child: AutoSizeText(
                            widget.customizableText.text,
                            minFontSize: 20,
                            maxFontSize: 200,
                            style: borderCtrl.borderStyle.copyWith(fontSize: 200),
                          ),
                        );
                      }),
                      GetBuilder<TextStyleController>(tag: widget.customizableText.id, builder: (ctr) {
                        return Container(
                          padding: EdgeInsets.only(top: 16),
                          child: AutoSizeText(
                              widget.customizableText.text,
                              minFontSize: 20,
                              maxFontSize: 200,
                              style: ctr.style.copyWith(fontSize: 200,)
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
