import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Utils/SqliteHelper.dart';
import 'package:zmongol/Utils/WordLogic.dart';
import 'package:zmongol/Utils/ZcodeLogic.dart';
//import 'package:get/get_state_manager/src/simple/get_state.dart';

class KeyboardController extends GetxController {
  List typeList = ['mongol', 'english', 'symbol'];

  int typeIndex = 0;
  var latin = ''.obs;
  get text => textEditingController.text;
  final TextEditingController textEditingController =
      TextEditingController(); //用于控制键盘输出的Controller
  int cursorPosition = 0;

  bool onShift = false;
  var words = ''.obs;
  var cands = <String>[]; //单词组成的列表，候选区的

  // MWordLogic mWordLogic = MWordLogic();
  // Map<String, List<String>> teinIlgal = MWordLogic.teinIlgal;
  // Map<String, String> databases = MWordLogic.databases;
  var zcode = new ZCode();
  SqliteHelper db = SqliteHelper();

  @override
  void onInit() {
    textEditingController.addListener(() {
      words.value = textEditingController.text;
    });
    super.onInit();
    ever(latin, (_) {
      return getWordFromDB();
    });

    db.open();
  }

  @override
  void onClose() {
    super.onClose();
    db.db.close();
    textEditingController.dispose();
    cands.clear();
    latin.value = '';
    typeIndex = 0;
  }

  changeKeyboardType(int value) {
    //value must be 0~2;
    if (cands.isNotEmpty) {
      enterAction(cands.first);
    }
    typeIndex = value;
    update(['kb']);
  }

  setLatin(String value, {bool isMongol = false}) {
    print('controller setLatin: $value');

    if (isMongol) {
      latin.value = value;
    } else {
      latin.value = '';
      cands.clear();
      update(['cands']);
      addText(value);
    }
  }

  setShift(bool value) {
    onShift = value;
    update(['shift', 'kb']);
  }

  changeShiftState() {
    onShift = !onShift;
    update(['shift', 'kb']);
  }

  setCursorPositon(int position) {
    textEditingController.selection =
        TextSelection.fromPosition(TextPosition(offset: position));
    cursorPosition = position;
  }

  cursorMoveUp() {
    setCursorPositon(cursorPosition - 1);
  }

  cursorMoveDown() {
    setCursorPositon(cursorPosition + 1);
  }

  void enterAction(String? v) {
    if (v == null) {
      String value = cands.first + ' ' + '\r';
      final text = textEditingController.text;
      final textSelection = textEditingController.selection;
      final newText =
          text.replaceRange(textSelection.start, textSelection.end, value);
      final myTextLength = value.length;
      textEditingController.text = newText;
      textEditingController.selection = textSelection.copyWith(
        baseOffset: textSelection.start + myTextLength,
        extentOffset: textSelection.start + myTextLength,
      );
    } else {
      String value = v + ' ';
      final text = textEditingController.text;
      // final textSelection = textEditingController.selection;
      // final textSelection =
      //     TextSelection.fromPosition(TextPosition(offset: cursorPosition));
      final cursorPosition = textEditingController.selection.base.offset;
      // Right text of cursor position
      String suffixText = textEditingController.text.substring(cursorPosition);

      // Add new text on cursor position

      int length = value.length;

      // Get the left text of cursor
      String prefixText =
          textEditingController.text.substring(0, cursorPosition);

      textEditingController.text = prefixText + value + suffixText;

      // Cursor move to end of added text
      textEditingController.selection = TextSelection(
        baseOffset: cursorPosition + length,
        extentOffset: cursorPosition + length,
      );
      // final newText =
      //     text.replaceRange(textSelection.start, textSelection.end, value);
      // final myTextLength = value.length;
      // textEditingController.text = newText;
      // textEditingController.selection = textSelection.copyWith(
      //   baseOffset: textSelection.start + myTextLength,
      //   extentOffset: textSelection.start + myTextLength,
      // );
      setCursorPositon(cursorPosition + length);
    }

    latin.value = '';
    cands.clear();
    update(['latin', 'cands']);
  }

  void deleteOne() {
    final text = textEditingController.text;
    final textSelection = textEditingController.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText =
          text.replaceRange(textSelection.start, textSelection.end, '');
      textEditingController.text = newText;
      textEditingController.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character

    final newStart = textSelection.start - 1;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(newStart, newEnd, '');
    textEditingController.text = newText;
    textEditingController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  void delelteAll() {
    latin.value = '';
    cands.clear();
    update(['cands']);
    textEditingController.text = '';
    textEditingController.selection = textEditingController.selection.copyWith(
      baseOffset: 0,
      extentOffset: 0,
    );
  }

  addText(String value) {
    final text = textEditingController.text;
    final textSelection = textEditingController.selection;
    final newText =
        text.replaceRange(textSelection.start, textSelection.end, value);
    final myTextLength = value.length;
    textEditingController.text = newText;
    textEditingController.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  getWordFromDB() async {
    if (latin.isNotEmpty) {
      String word = '';
      var words = [];
      cands.clear();
      List<Map<String, dynamic>> list = [];
      // word = mWordLogic.excute(latin.value);
      words = zcode.ExcuteEx(latin.value);
      cands.insertAll(0, words.map((e) => e));
      if (latin.value == 'q') {
        cands.addAll(MWordLogic.qArray);
      }
      if (latin.value == 'c') {
        cands.addAll(MWordLogic.vArray);
      }
      list = List.from(await db.queryWords(latin.substring(0, 1), latin.value));

      if (list.isNotEmpty) {
        print('Map:${list.first}');
        int j = 0;
        for (int i = 0; i < list.length; i++) {
          print('list${list[i]}');
          print('cands.first${cands.first}');
          if (cands.first == list[i]['word'].toString().trim()) {
            list.removeAt(i);
            j++;
          } else {
            cands.add(list[i]['word']);
          }
          // if (cands.first == list[i]['MONGOL'].toString().trim()) {
          //   list.removeAt(i);
          //   j++;
          // } else {
          //   cands.add(list[i]['MONGOL']);
          // }
        }

        print('j:$j');
      }
      update(['cands']);
      // return list;
    } else {
      cands.clear();
      update(['cands']);
    }
  }
}
