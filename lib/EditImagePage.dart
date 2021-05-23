import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zmongol/Component/CustomizableText.dart';
import 'package:zmongol/Component/MongolTextBox.dart';
import 'package:zmongol/Controller/TextController.dart';

import 'Component/ColorPicker.dart';
import 'Component/FontPicker.dart';
import 'Component/MongolFonts.dart';
import 'Component/MongolToolTip.dart';
import 'Controller/StyleController.dart';
import 'EditorPage.dart';
import 'Utils/ImageUtil.dart';

class EditImagePage extends StatefulWidget {
  EditImagePage(this.image);
  final File image;

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  GlobalKey repaintWidgetKey = GlobalKey();
  double scale = 1.0;
  double rotation = 0;
  double dx = 16.0;
  double dy = 16.0;
  bool editable = true;
  List<CustomizableText> mongolTextBoxes = [];
  int maxNumberOfTextBoxes = 10;
  String selectedBoxTag = '';

  @override
  void initState() {
    super.initState();
  }

  List<Widget> textBoxesView() {
    if (mongolTextBoxes.isEmpty) {
      return [Container()];
    }
    List<Widget> widgets = [];
    widgets.add(
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
        )
    );

    mongolTextBoxes.forEach((element) {
      if (element.tag != selectedBoxTag) {
        element.editable = false;
      } else {
        element.editable = true;
      }
      final textBoxView = MongolTextBox(
        element,
        onTextBoxTapped: () {
          _onTextBoxTapped(element);
        },
        onTextBoxDeleted: () {
          _onTextBoxDeleted(element);
        },
        onEditButtonPressed: () {
          _goToEditPage(element);
        },
        onCopyButtonPressed: () {
          _copyTextBox(element);
        },
      );
      widgets.add(textBoxView);
    });
    return widgets;
  }

  _onTextBoxTapped(CustomizableText target) {
    setState(() {
      editable = true;
      selectedBoxTag = target.tag;
    });
  }

  _onTextBoxDeleted(CustomizableText target) {
    setState(() {
      selectedBoxTag = '';
      mongolTextBoxes.removeWhere((customizableText) => customizableText.tag == target.tag);
      Get.delete<TextStyleController>(tag: target.tag);
      Get.delete<TextStyleController>(tag: 'border_style_'+ target.tag);
      Get.delete<StyleController>(tag: target.tag);
    });
  }

  _goToEditPage(CustomizableText target) async {
    String? newText = await Get.to(EditorPage(editWithImage: true, text: target.text));
    if (newText == null || newText == target.text) {
      return;
    }
    setState(() {
      target.text = newText;
    });
  }

  _copyTextBox(CustomizableText target) {
    CustomizableText customizableText = CustomizableText(tag: DateTime.now().toString(), text: target.text, editable: true, copyFromTag: target.tag);
    mongolTextBoxes.add(customizableText);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('ᢜᡪᡪᢊᢛᡭᢑᡪᡪᡪᡳ', style: TextStyle(fontFamily: MongolFonts.haratig)),
          centerTitle: true,
          actions: editable ? [
            mongolTextBoxes.length < maxNumberOfTextBoxes ? IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () async {
                  Get.to(EditorPage(editWithImage: true))?.then((value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      final newMongolTextBox = CustomizableText(tag: DateTime.now().toString(), text: value, editable: true);
                      selectedBoxTag = newMongolTextBox.tag;
                      mongolTextBoxes.add(newMongolTextBox);
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
                    selectedBoxTag = '';
                    editable = false;
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
                  key: repaintWidgetKey,
                  child: Stack(
                    children: [
                      Image.file(
                        widget.image,
                        fit: BoxFit.fill,
                      ),
                      ...textBoxesView()
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
                      FontsPicker().fontFamily(selectedBoxTag);
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
                        ColorPicker().font(selectedBoxTag);
                      })),
              MongolTooltip(
                message: 'ᢘᡪᢑᢊᡪᢚᡧ ᡬᡬᡧ ᡥᡭᡬᡪᢊᢊᡪᡨ ',
                textStyle: TextStyle(fontSize: 18, color: Colors.white, fontFamily: MongolFonts.haratig),
                showDuration: Duration(seconds: 3),
                waitDuration: Duration(milliseconds: 500),
                child: IconButton(
                    icon: Icon(Icons.format_color_fill),
                    onPressed: () {
                      ColorPicker().background(selectedBoxTag);
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
                        ColorPicker().shadow(selectedBoxTag);
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
                        ColorPicker().borderColor(selectedBoxTag);
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
