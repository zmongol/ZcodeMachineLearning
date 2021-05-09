import 'dart:io';

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
import 'EditorPage.dart';
import 'Utils/ImageUtil.dart';

class EditImagePage extends StatefulWidget {
  EditImagePage(this.image);
  final File image;

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  Offset _lastOffset = Offset(0, 0);
  double scale = 1.0;
  double rotation = 0;
  double dx = 16.0;
  double dy = 16.0;
  bool editAble = true;
  List<String> texts = [];

  textBoxes() {
    if (texts.isEmpty) {
      return Container();
    }
    return Stack(
      children: [
        Positioned(
            bottom: 8,
            right: 8,
            child: GetBuilder<TextStyleController>(
                builder: (ctr) => Text(
                    'Z',
                    style: TextStyle(
                      fontSize: 14,
                      color: ctr.style.color,
                    )
                )
            )
        ),
        Positioned(
          top: dy,
          left: dx,
          child: GetBuilder<StyleController>(
            builder: (styleCtr) => GestureDetector(
              onPanDown: (DragDownDetails e) {
                print("用户手指按下：${e.globalPosition}");
              },
              onPanEnd: (DragEndDetails e) {
                print(e.velocity);
              },
              onPanUpdate: (DragUpdateDetails d) {
                if (editAble == false) {
                  editAble = true;
                }
                setState(() {
                  dx += d.delta.dx;
                  dy += d.delta.dy;
                });
                print('onPanUpdate dx:$dx');
                print('onPanUpdate dy:$dy');
              },
              child: DragToResizBox(
                width: styleCtr.width.value,
                height: styleCtr.height.value,
                editable: editAble,
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
                      GetBuilder<TextStyleController>(tag: 'border_style', builder: (borderCtrl) {
                        return Container(
                          padding: EdgeInsets.only(top: 16),
                          child: AutoSizeText(
                            texts.first,
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
                              texts.first,
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
          title: Text('ᢜᡪᡪᢊᢛᡭᢑᡪᡪᡪᡳ', style: TextStyle(fontFamily: MongolFonts.haratig)),
          centerTitle: true,
          actions: editAble ? [
            texts.isEmpty ? IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () async {
                  Get.to(EditorPage(editWithImage: true))?.then((value) {
                    texts.add(value);
                    setState(() {

                    });
                  });
                }) : Container(),
            IconButton(
                icon: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    editAble = false;
                  });
                })
          ]
              : [
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
        body: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                child: RepaintBoundary(
                  key: editAble ? null : repaintWidgetKey,
                  child: Stack(
                    children: [
                      Image.file(
                        widget.image,
                        fit: BoxFit.fill,
                      ),
                      textBoxes()
                    ],
                  ),
                ),
              ),   
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MongolTooltip(
                message: 'ᡥᡭᡬᢔᡭᡬᡨ ᡭᡧ ᢘᡬᡬᡨ ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
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
                  textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                  showDuration: Duration(seconds: 3),
                  waitDuration: Duration(milliseconds: 500),
                  child: IconButton(
                      icon: Icon(Icons.color_lens_outlined),
                      onPressed: () {
                        ColorPicker().font();
                      })),
              MongolTooltip(
                message: 'ᢘᡪᢑᢊᡪᢚᡧ ᡬᡬᡧ ᡥᡭᡬᡪᢊᢊᡪᡨ ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: IconButton(
                    icon: Icon(Icons.format_color_fill),
                    onPressed: () {
                      ColorPicker().background();
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
                        ColorPicker().shadow();
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
                        ColorPicker().borderColor();
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
