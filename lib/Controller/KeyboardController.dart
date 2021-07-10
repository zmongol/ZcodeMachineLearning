import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmongol/Utils/ZcodeLogic.dart';
import 'package:zmongol/machine_learning/mongol_ml_autocomplete.dart';

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

  var zcode = new ZCode();
  var mlAutocomplete = MongolMLAutocomplete();

  @override
  void onInit() {
    textEditingController.addListener(() {
      words.value = textEditingController.text;
    });
    super.onInit();
    ever(latin, (_) {
      return suggestWords();
    });

    mlAutocomplete.initialize();
  }

  @override
  void onClose() {
    super.onClose();
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

  void enterAction(String? v) async {
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
      v = v.trim();
      String value = v + ' ';
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
      setCursorPositon(cursorPosition + length);
    }

    latin.value = '';
    cands.clear();
    var suggestions =
        await _getSuggestionsFromML([textEditingController.text], true);
    cands.addAll(suggestions);

    update(['latin', 'cands']);
  }

  void deleteOne() async {
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

    // Get the whole text being written, and feed it into the ML algorithm
    // If the whole text consists of a single word, suggest possible autocompletion for that particular word
    // If it's 2 words or more, suggest possible new words for that sentence.
    var trimmedText = textEditingController.text.trim();
    var isSentence = trimmedText.split(' ').length > 1;

    var suggestions = await _getSuggestionsFromML([trimmedText], isSentence);

    _emitNewSuggestions(suggestions);
  }

  // Notify listeners that there are new word suggestions
  void _emitNewSuggestions(List<String> words) {
    cands.clear();
    cands.addAll(words);

    update(['cands']);
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

  suggestWords() async {
    cands.clear();
    if (latin.isNotEmpty) {
      var words = List<String>.from(zcode.ExcuteEx(latin.value));
      cands.addAll(words.sublist(0, words.length - 1));

      // Lookup special words that are hard to type
      var specialWord = dagbr[latin];

      if (specialWord != null) {
        print('add special word $specialWord');
        cands.add(specialWord);
      }

      List<String> wordWithoutTail =
          words.sublist(words.length - 1, words.length);
      var suggestions = await _getSuggestionsFromML(wordWithoutTail, false);
      cands.addAll(suggestions);
    }
    update(['cands']);
  }

  /// Retrieves suggestions from Machine Learning model
  /// IMPORTANT NOTE: make sure each word ends with a space, otherwise
  /// the ML doesn't return any suggestions
  Future<List<String>> _getSuggestionsFromML(
      List<String> words, bool isSentence) async {
    var start = DateTime.now().millisecondsSinceEpoch;
    var result = <String>[];
    for (var word in words) {
      if (word.isNotEmpty) {
        print("Getting autocomplete for $word");
        Set<String> suggestions = await mlAutocomplete.runCustomModel(word);

        if (isSentence) {
          result.addAll(suggestions.map((str) {
            //First, remove excess space at the end
            //Break down the sentence into words
            var wordList = str.trimRight().split(" ");

            //If there are 2 or more words, return the last word
            //Else return the string 'str'
            if (wordList.length > 1) {
              return wordList[wordList.length - 1] + " ";
            } else {
              return str;
            }
          }).toList());
        } else {
          result.addAll(suggestions);
        }
      }
    }

    var end = DateTime.now().millisecondsSinceEpoch;
    print('total time taken for ML: ${end - start}ms');

    print("Autocomplete result: $result");
    return result.sublist(0);
  }

  // ///Retrieves word suggestions from local DB and appends to list of suggestions
  // _getSuggestionsFromDB() async {
  //   if (latin.value == 'q') {
  //     cands.addAll(MWordLogic.qArray);
  //   }
  //   if (latin.value == 'c') {
  //     cands.addAll(MWordLogic.vArray);
  //   }

  //   List<Map<String, dynamic>> list = [];
  //   list = List.from(await db.queryWords(latin.substring(0, 1), latin.value));

  //   if (list.isNotEmpty) {
  //     for (int i = 0; i < list.length; i++) {
  //       if (cands.first == list[i]['word'].toString().trim()) {
  //         list.removeAt(i);
  //       } else {
  //         cands.add(list[i]['word']);
  //       }
  //     }
  //   }
  // }
}
