import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:zmongol/Component/AutoSizeText/auto_size_text.dart';
import 'package:zmongol/Component/DragToResizeBox.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'package:zmongol/Controller/TextController.dart';

import 'Component/ColorPicker.dart';
import 'Component/FontPicker.dart';
import 'Component/MongolToolTip.dart';
import 'Utils/ImageUtil.dart';

class SharePage extends StatefulWidget {
  SharePage(
    this.text,
  );
  final String text;

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  // MongolTextPainter _textPainter;
  int wordCount = 0;
  int lines = 0;
  double lineHeight = 0.0;
  double lineWidth = 0.0;
  get canvasWidth => lines * lineWidth;
  get canvasHeight => lineHeight;

  @override
  void initState() {
    // List<String> wordList = widget.text.split(' ');
    // wordList = wordList.where((element) => element.isNotEmpty);
    // wordCount = wordList.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey repaintWidgetKey = GlobalKey(); // 绘图key值

    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          title: Text('ᢜᡪᡪᢊᢛᡭᢑᡪᡪᡪᡳ'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  saveToGallery(repaintWidgetKey);
                }),
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  //open share menu
                  shareUiImage(repaintWidgetKey);
                }),
          ],
        ),
        body: Center(
          child: GetBuilder<StyleController>(
            builder: (styleCtr) => DragToResizBox(
              width: styleCtr.width.value,
              height: styleCtr.height.value,
              editable: true,
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
                color: Colors.grey.shade200,
                child: RepaintBoundary(
                  key: repaintWidgetKey,
                  child: Stack(
                    children: [
                      Container(
                        width: styleCtr.width.value,
                        height: styleCtr.height.value,
                        padding: const EdgeInsets.all(4),
                        color: styleCtr.backgroundColor,
                        child: GetBuilder<TextStyleController>(
                          builder: (ctr) => Center(
                            child: AutoSizeText(widget.text,
                                minFontSize: 10,
                                maxFontSize: 99,
                                style: ctr.style.copyWith(
                                  fontSize: 99,
                                )),

                            //MongolText(
                            //widget.text,
                            //style: ctr.style,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 8,
                          right: 8,
                          child: GetBuilder<TextStyleController>(
                              builder: (ctr) => Text('Z',
                                  style: TextStyle(
                                      fontSize: 14, color: ctr.style.color))))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Tooltip(
              //   message: 'ᡥᡭᡬᢔᡭᡬᡨ ᡭᡧ ᢜᡪᢊᡪᡨ ᡳᡪᢉᡨ  ',
              //   textStyle: TextStyle(fontSize: 18, color: Colors.white),
              //   showDuration: Duration(seconds: 3),
              //   waitDuration: Duration(milliseconds: 500),
              //   child: IconButton(
              //       icon: Stack(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 8),
              //             child: Text('A',
              //                 style: TextStyle(
              //                     fontSize: 20, fontWeight: FontWeight.w600)),
              //           ),
              //           Positioned(
              //               right: 0,
              //               bottom: 0,
              //               child: Text('a',
              //                   style: TextStyle(
              //                       fontSize: 16, fontWeight: FontWeight.w600)))
              //         ],
              //       ),
              //       onPressed: () {
              //         FontsPicker().fontSize();
              //       }),
              // ),
              MongolTooltip(
                message: 'ᡥᡭᡬᢔᡭᡬᡨ ᡭᡧ ᢘᡬᡬᡨ ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: IconButton(
                    icon: Icon(Icons.text_fields),
                    onPressed: () {
                      FontsPicker().fontFamily();
                    }),
              ),
              MongolTooltip(
                  message: 'ᡥᡭᡬᢔᡭᡬᡨ ᡭᡧ ᡥᡭᡬᡪᢊᢊᡪᡨ  ',
                  textStyle: TextStyle(fontSize: 18, color: Colors.white),
                  showDuration: Duration(seconds: 3),
                  waitDuration: Duration(milliseconds: 500),
                  child: IconButton(
                      icon: Icon(Icons.color_lens_outlined),
                      onPressed: () {
                        ColorPicker().font();
                      })),
              MongolTooltip(
                message: 'ᢘᡪᢑᢊᡪᢚᡧ ᡬᡬᡧ ᡥᡭᡬᡪᢊᢊᡪᡨ ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: IconButton(
                    icon: Icon(Icons.format_color_fill),
                    onPressed: () {
                      ColorPicker().background();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
