import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mongol/mongol.dart';
import 'package:zmongol/Component/MongolToolTip.dart';
import 'package:zmongol/Controller/KeyboardController.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'package:zmongol/Model/CustomizableText.dart';
import 'package:zmongol/widgets/word_suggestions_section.dart';
import 'package:zmongol/utils/global_key_extension.dart';

import '../Component/MongolFonts.dart';
import '../Controller/TextController.dart';
import '../Keyboard/MongolKeyboard.dart';
import 'Share.dart';

///photoWithText
class EditorPage extends StatefulWidget {
  final bool editWithImage;
  final String? text;
  EditorPage({required this.editWithImage, this.text});

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final containerKey = GlobalKey();
  final tfKey = GlobalKey();
  bool overlayOffsetIsInitialed = false;
  FocusNode _focusNode = FocusNode();
  int cursorOffset = 0;
  bool editable = true;
  int layoutTime = 0;

  //double canvasWidth = 300.0;
  //   double canvasHeight = 480.0;
  List<String> teinIlgalCands = [
    'ᡭᡧ',
    'ᡬᡬᡧ',
    'ᡳ',
    "ᡭᡳ",
    "ᡳᡪᢝ",
    "ᡬᡬᡪᢝ",
    "ᡳᡪᡧ",
    "ᡬᡬᡪᡧ",
    'ᢘᡳ',
    'ᢙᡳ',
    'ᡬᡫ',
    'ᡫ',
    'ᡥᢚᡧ',
    "ᢘᡪᡫ",
    "ᡭᡭᡧ",
    "ᢘᡪᡱᡱᡪᡧ",
    "ᢘᡪᢊᡪᡧ",
    "ᢙᡪᡱᡱᡪᡧ",
    "ᢙᡪᢊᡪᡧ",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                'Z ᢌᡭᡪᢊᡱᡱᡭᢐ',
                style: TextStyle(fontFamily: MongolFonts.haratig),
              ),
              centerTitle: true,
              backgroundColor: Colors.indigo,
              actions: [
                GetBuilder<KeyboardController>(
                  id: 'cands',
                  builder: (ctr) {
                    return IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: ctr.text.isNotEmpty
                          ? () {
                              Get.dialog(MongolAlertDialog(
                                title: MongolText('ᡥᡪᡪᢊᡪᡪᡪᢞᡪᡪᡳ',
                                    // title: Text('Alert',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 32,
                                        fontFamily: MongolFonts.haratig)),
                                content: MongolText('ᡴᡭᡬᢋᡭᡧ ᡫ ᡥᡪᢞᢚᡬᡪᡪᡳ ᡭᡳ ᡓ',
                                    // content: Text('Confirm Delete?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: MongolFonts.haratig)),
                                actions: <Widget>[
                                  TextButton(
                                    child: MongolText(
                                      'ᡴᡭᢚᡪᡰᡨ',
                                      // 'cancel',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: MongolFonts.haratig),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: MongolText(
                                      'ᡥᡪᢞᢚᡬᡰᡨ',
                                      // 'delete',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontFamily: MongolFonts.haratig),
                                    ),
                                    onPressed: () {
                                      ctr.delelteAll();
                                      Get.back();
                                    },
                                  ),
                                ],
                              ));
                            }
                          : null,
                    );
                  },
                ),
                GetBuilder<KeyboardController>(
                  id: 'cands',
                  builder: (ctr) => IconButton(
                      icon: Icon(Icons.done),
                      onPressed: ctr.text.isNotEmpty
                          ? () {
                              ctr.setLatin('', isMongol: false);
                              // NOTE: if we're editing an existing text box, go back to previous screen
                              if (widget.text != null) {
                                Get.back(result: ctr.text);
                                return;
                              }
                              if (widget.editWithImage) {
                                Get.back(result: ctr.text);
                              } else {
                                CustomizableText text = CustomizableText(
                                    tag: DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString(),
                                    text: ctr.text,
                                    editable: true);
                                Get.to(SharePage(text));
                              }
                            }
                          : null),
                )
              ],
            ),
            body: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            GetBuilder<StyleController>(
                              builder: (styleCtr) => Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(4),
                                child: GetBuilder<TextStyleController>(
                                  builder: (ctr) {
                                    print(
                                        'now fontsize = ${ctr.style.fontSize}');
                                    return GetBuilder<KeyboardController>(
                                      builder: (kbCtr) {
                                        if (widget.text != null) {
                                          kbCtr.textEditingController.text =
                                              widget.text!;
                                        } else {
                                          kbCtr.textEditingController.text = '';
                                        }
                                        return MongolTextField(
                                          key: tfKey,
                                          scrollPadding:
                                              const EdgeInsets.only(),
                                          autofocus: true,
                                          showCursor: true,
                                          readOnly: true,
                                          focusNode: _focusNode,
                                          // expands: true,
                                          maxLines: 100,
                                          minLines: 1,
                                          controller:
                                              kbCtr.textEditingController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(),
                                            border: InputBorder.none,
                                          ),
                                          // keyboardType: MongolKeyboard.inputType,
                                          textInputAction:
                                              TextInputAction.newline,
                                          //keyboardType: TextInputType.multiline,
                                          style: TextStyle(
                                              fontSize: ctr.style.fontSize,
                                              fontFamily: MongolFonts.haratig),
                                          //像平常一样设置键盘输入类型一样将Step1编写的inputType传递进去
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 1 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio))),
                            ),
                            Container(
                              width: 50,
                              child: Column(
                                children: [
                                  GetBuilder<TextStyleController>(
                                      builder: (ctr) => IconButton(
                                          icon: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text('A',
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ),
                                              Positioned(
                                                  right: 0, child: Text('+'))
                                            ],
                                          ),
                                          onPressed: () {
                                            ctr.increaseFontSize();
                                          })),
                                  GetBuilder<TextStyleController>(
                                    builder: (ctr) => IconButton(
                                        icon: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'A',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Positioned(
                                                right: 0, child: Text('-'))
                                          ],
                                        ),
                                        onPressed: () {
                                          ctr.decreaseFontSize();
                                        }),
                                  ),
                                  MongolTooltip(
                                    message:
                                        'ᡳᡬᢚᡬᢑᢊᡪᡨ  ᡭᡧ  ᢚᡬᡬᡨ ᡫ ᢘᡪᢊᡪᢊᢔᡫ ᢔᡬᢑᢛᡬᢋᡭᢑᢋᡭ',
                                    showDuration: Duration(seconds: 3),
                                    child: GetBuilder<KeyboardController>(
                                      builder: (ctr) => IconButton(
                                          icon: RotatedBox(
                                              quarterTurns: 1,
                                              child: Icon(Icons.skip_previous)),
                                          onPressed: () {
                                            ctr.cursorMoveUp();
                                          }),
                                    ),
                                  ),
                                  MongolTooltip(
                                    message:
                                        'ᡳᡬᢚᡬᢑᢊᡪᡨ  ᡭᡧ  ᢚᡬᡬᡨ ᡫ ᢘᡭᢞᡭᡪᡪᢔᡫ ᢔᡬᢑᢛᡬᢋᡭᢑᢋᡭ',
                                    showDuration: Duration(seconds: 3),
                                    child: GetBuilder<KeyboardController>(
                                      builder: (ctr) => IconButton(
                                          icon: RotatedBox(
                                              quarterTurns: 3,
                                              child: Icon(Icons.skip_previous)),
                                          onPressed: () {
                                            ctr.cursorMoveDown();
                                          }),
                                    ),
                                  ),
                                  MongolTooltip(
                                    message: 'ᡸᡪᡱᡱᡭᢑᡪᡪᡳ ',
                                    child: GetBuilder<KeyboardController>(
                                      builder: (ctr) => IconButton(
                                          icon: Icon(Icons.copy),
                                          onPressed: () {
                                            ClipboardData data =
                                                new ClipboardData(
                                                    text: ctr.text);
                                            if (ctr.text != null) {
                                              //增加个判断防止复制null，避免闪退
                                              Clipboard.setData(data);
                                              Get.snackbar(
                                                  'Successfully copied ',
                                                  'the content is copied to your phone',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                            }
                                          }),
                                    ),
                                  ),
                                  MongolTooltip(
                                    message: 'ᡯᡪᡱᡱᡪᡪᡪᡳ ',
                                    child: GetBuilder<KeyboardController>(
                                      builder: (ctr) => IconButton(
                                          icon: Icon(Icons.paste),
                                          onPressed: () async {
                                            ClipboardData? data =
                                                await Clipboard.getData(
                                                    Clipboard.kTextPlain);
                                            if (data != null &&
                                                data.text != null) {
                                              ctr.addText(data.text!);
                                            }
                                            //之前忘了添加到文本里
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GetBuilder<KeyboardController>(
                        id: 'cands',
                        builder: (ctr) {
                          return Material(
                            color: Colors.grey.shade100,
                            elevation: 3,
                            child: Container(
                              key: containerKey,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(),
                                  Flexible(
                                    child: WordSuggestionsSection(
                                      height: 40,
                                      words: teinIlgalCands,
                                      onWordTap: (word) {
                                        ctr.enterAction(word);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    // color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    MongolKeyboard()
                  ],
                ),
                GetBuilder<KeyboardController>(
                  id: 'cands',
                  builder: (ctr) => ctr.cands.isNotEmpty
                      ? Positioned(
                          top: _calculateOffsetForSuggestions(ctr.latin.value),
                          left: tfKey.globalPaintBounds!.right + 20,
                          child: Container(
                            // height: 100,
                            width: 175,
                            constraints: BoxConstraints(
                              maxHeight: 300,
                              minHeight: 100,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: Obx(
                                    () => Text(
                                      ctr.latin.value,
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                                Container(
                                  height:
                                      _calculateCandsHeight(ctr.latin.value),
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: ctr.cands.length,
                                    itemBuilder: (_, index) {
                                      var word = ctr.cands[index];
                                      return GestureDetector(
                                        onTap: () {
                                          ctr.enterAction(word);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 6.0,
                                          ),
                                          child: MongolText(
                                            word,
                                            style: TextStyle(
                                              fontFamily: 'haratig',
                                              fontSize: ScreenUtil().setSp(24),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, index) =>
                                        VerticalDivider(
                                      width: 1.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Calculates offset from top of screen for suggestions section
  /// Takes into account the current height to prevent the section
  /// from overflowing into bottom of the screen
  double _calculateOffsetForSuggestions(String latin) =>
      containerKey.globalPaintBounds!.top -
      ScreenUtil().setHeight(120) -
      _calculateCandsHeight(latin);

  ///Calculates height for suggestions section
  ///Based on length of current latin input
  double _calculateCandsHeight(String latin) => latin.length >= 7
      ? latin.length * ScreenUtil().setHeight(6.0) + ScreenUtil().setHeight(60)
      : ScreenUtil().setHeight(90.0);
}
