import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:zmongol/Component/AutoSizeText/auto_size_text.dart';
import 'package:zmongol/Component/DragToResizeBox.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'package:zmongol/Controller/TextController.dart';
import 'package:zmongol/Model/CustomizableText.dart';
import 'package:zmongol/Screen/StartPage.dart';
import 'package:zmongol/Utils/HistoryHelper.dart';

import '../Component/ColorPicker.dart';
import '../Component/FontPicker.dart';
import '../Component/MongolFonts.dart';
import '../Component/MongolToolTip.dart';
import 'EditorPage.dart';
import '../Utils/ImageUtil.dart';

class SharePage extends StatefulWidget {
  SharePage(this.customizableText);
  final CustomizableText customizableText;

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  late final String tag;
  late final TextStyleController textController;
  late final TextStyleController borderController;
  late final StyleController styleController;
  String text = '';
  bool isFromHistory = false;

  @override
  void initState() {
    tag = widget.customizableText.tag;
    textController = Get.put<TextStyleController>(TextStyleController(), tag: tag);
    borderController = Get.put<TextStyleController>(TextStyleController(), tag: 'border_style_' + tag);
    styleController = Get.put<StyleController>(StyleController(), tag: tag);
    text = widget.customizableText.text;
    loadHistoryStyle();
    super.initState();
  }

  Color getColorFromString(String s) {
    return Color(int.parse('0x$s'));
  }

  loadHistoryStyle() async {
    if (widget.customizableText.isHistoryItem == 0) {
      return;
    }
    var mongolTextBoxStyle = await HistoryHelper.instance.getMongolTextBoxStyleByTextId(widget.customizableText.id!);
    if (mongolTextBoxStyle != null) {
      textController.setColor(getColorFromString(mongolTextBoxStyle.textColor));
      textController.setBorderColor(getColorFromString(mongolTextBoxStyle.borderColor));
      textController.setFontFamily(mongolTextBoxStyle.fontFamily);
      textController.setShadowColor(getColorFromString(mongolTextBoxStyle.shadowColor));
      textController.setFontSize(mongolTextBoxStyle.fontSize);
      borderController.setBorderColor(getColorFromString(mongolTextBoxStyle.borderColor));
      borderController.setFontFamily(mongolTextBoxStyle.fontFamily);
      styleController.height.value = mongolTextBoxStyle.height;
      styleController.width.value = mongolTextBoxStyle.width;
      styleController.setBackgroundColor(getColorFromString(mongolTextBoxStyle.backgroundColor));
      mongolTextBoxStyle = null;
      widget.customizableText.isHistoryItem = 0;
      setState(() {});
    }

  }

  saveToHistory(Uint8List? previewImageData) async {
    final customizableText = CustomizableText(tag: tag, text: text, editable: false, dx: 0, dy: 0);
    await HistoryHelper.instance.saveToHistory('.png', null, previewImageData, [customizableText]);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey repaintWidgetKey = GlobalKey();
    // 绘图key值

    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.offAll(StartPage());
            },
          ),
          title: Text('ᢜᡪᡪᢊᢛᡭᢑᡪᡪᡪᡳ',style: TextStyle(fontFamily: MongolFonts.haratig)),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () async {
                  final Uint8List? bytes = await saveToGallery(repaintWidgetKey);
                  saveToHistory(bytes);
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
          child: Obx(
            () => DragToResizeBox(
              width: styleController.width.value,
              height: styleController.height.value,
              editable: true,
              deletable: false,
              onWidthChange: (v) {
                setState(() {
                  styleController.width.value += v;
                });
              },
              onHeightChange: (v) {
                setState(() {
                  styleController.height.value += v;
                });
              },
              onEditButtonPressed: () async {
                String? newText = await Get.to(EditorPage(editWithImage: true, text: text));
                if (newText== null || newText == text) {
                  return;
                }
                setState(() {
                  text = newText;
                });
              },
              child: Container(
                color: Colors.grey.shade200,
                child: RepaintBoundary(
                  key: repaintWidgetKey,
                  child: Stack(
                    children: [
                      Container(
                        width: styleController.width.value,
                        height: styleController.height.value,
                        color: styleController.backgroundColor,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 16),
                              child: AutoSizeText(
                                text,
                                minFontSize: 20,
                                maxFontSize: 200,
                                style: borderController.borderStyle.copyWith(fontSize: 200),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 16),
                              child: AutoSizeText(
                                  text,
                                  minFontSize: 20,
                                  maxFontSize: 200,
                                  style: textController.style.copyWith(fontSize: 200,)
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 8,
                          right: 8,
                          child: Text(
                              'Z',
                              style: TextStyle(fontSize: 14)))
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
              MongolTooltip(
                message: 'ᡥᡭᡬᢔᡭᡬᡨ ᡭᡧ ᢘᡬᡬᡨ ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: IconButton(
                    icon: Icon(Icons.text_fields),
                    onPressed: () {
                      FontsPicker().fontFamily(tag);
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
                        ColorPicker().font(tag);
                      })),
              MongolTooltip(
                message: 'ᢘᡪᢑᢊᡪᢚᡧ ᡬᡬᡧ ᡥᡭᡬᡪᢊᢊᡪᡨ ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: IconButton(
                    icon: Icon(Icons.format_color_fill),
                    onPressed: () {
                      ColorPicker().background(tag);
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
                        ColorPicker().shadow(tag);
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
                        ColorPicker().borderColor(tag);
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
