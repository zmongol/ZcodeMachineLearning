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
import 'Component/MongolFonts.dart';
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
          backgroundColor: Colors.indigo,
          title: Text('ᢜᡪᡪᢊᢛᡭᢑᡪᡪᡪᡳ',style: TextStyle(fontFamily: MongolFonts.haratig)),
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
            builder: (styleCtr) => DragToResizeBox(
              width: styleCtr.width.value,
              height: styleCtr.height.value,
              editable: true,
              deletable: false,
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
                        color: styleCtr.backgroundColor,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            GetBuilder<TextStyleController>(tag: 'border_style', builder: (borderCtrl) {
                              return Container(
                                padding: EdgeInsets.only(top: 16),
                                child: AutoSizeText(
                                  widget.text,
                                  minFontSize: 20,
                                  maxFontSize: 200,
                                  style: borderCtrl.borderStyle.copyWith(fontSize: 200),
                                ),
                              );
                            }),
                            GetBuilder<TextStyleController>(builder: (ctr) {
                              return Container(
                                padding: EdgeInsets.only(top: 16),
                                child: AutoSizeText(
                                    widget.text,
                                    minFontSize: 20,
                                    maxFontSize: 200,
                                    style: ctr.style.copyWith(fontSize: 200,)
                                ),
                              );
                            }),
                          ],
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
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: IconButton(
                    icon: Icon(Icons.text_fields),
                    onPressed: () {
                      FontsPicker().fontFamily('');
                    }),
              ),
              MongolTooltip(
                  message: 'ᡥᡭᡬᢔᡭᡬᡨ ᡭᡧ ᡥᡭᡬᡪᢊᢊᡪᡨ  ',
                  textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                  showDuration: Duration(seconds: 3),
                  waitDuration: Duration(milliseconds: 500),
                  child: IconButton(
                      icon: Icon(Icons.color_lens_outlined),
                      onPressed: () {
                        ColorPicker().font('');
                      })),
              MongolTooltip(
                message: 'ᢘᡪᢑᢊᡪᢚᡧ ᡬᡬᡧ ᡥᡭᡬᡪᢊᢊᡪᡨ ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: IconButton(
                    icon: Icon(Icons.format_color_fill),
                    onPressed: () {
                      ColorPicker().background('');
                    }),
              ),
              MongolTooltip(
                message: 'ᡥᡭᡬᢔᡭᡬᡨ ᡭᡧ ᢔᡪᢋᡭᢙᡪᢝ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: GetBuilder<TextStyleController>(
                  builder: (ctr) => IconButton(
                      icon: Text(
                        'T',
                        style: TextStyle(
                            color: ctr.textShadowAble
                                ? Colors.indigo
                                : Colors.black,
                            fontSize: 20,
                            fontFamily: 'segoeui',
                            shadows: [
                              Shadow(
                                  color: ctr.textShadowAble
                                      ? Colors.indigo.withOpacity(0.7)
                                      : Colors.black.withOpacity(0.7),
                                  offset: Offset(2, 2),
                                  blurRadius: 3)
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        ColorPicker().shadow('');
                      }),
                ),
              ),
              MongolTooltip(
                message: 'ᢋᡭᡬᢞᡬᢜᡪᢑᡪᢋᡭ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: GetBuilder<TextStyleController>(
                  builder: (ctr) => IconButton(
                      icon: Text(
                        'B',
                        style: TextStyle(
                            color: ctr.textShadowAble
                                ? Colors.indigo
                                : Colors.black,
                            fontSize: 20,
                            fontFamily: 'segoeui',
                            shadows: [
                              Shadow(
                                  color: ctr.textShadowAble
                                      ? Colors.indigo.withOpacity(0.7)
                                      : Colors.black.withOpacity(0.7),
                                  offset: Offset(2, 2),
                                  blurRadius: 3)
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        ColorPicker().borderColor('');
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
