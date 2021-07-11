import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:pytorch_mobile/enums/dtype.dart';
import 'package:pytorch_mobile/model.dart';
import 'package:pytorch_mobile/pytorch_mobile.dart';

class MongolMLAutocomplete {
  static const String pathCustomModel = "assets/machine_learning/zmodel.pt";
  static const String pathMappings =
      "assets/machine_learning/new_char_to_token.json";
  late Model _customModel;

  // mappings from token to characters and vise versa.
  late Map<String, int> charToTokenMapping;
  late Map<int, String> tokenToCharMapping;

  // configuration variables
  final int
      blockSize; // maximum context to look back when running model inference.
  final int numberOfSampleWords; // max number of attempts for generating words.
  final int maxLengthOfWord; // max length of a word

  var rng = new Random();

  MongolMLAutocomplete({
    this.blockSize = 20,
    this.numberOfSampleWords = 10,
    this.maxLengthOfWord = 20,
  });

  Future initialize() async {
    print('loading model');
    loadModel();

    print('loading mappings');
    loadMappings();
  }

  //load your model
  Future loadModel() async {
    try {
      _customModel = await PyTorchMobile.loadModel(pathCustomModel);
    } on PlatformException {
      print("only supported for android and ios so far");
    }
  }

  Future loadMappings() async {
    try {
      String jsonString = await rootBundle.loadString(pathMappings);
      charToTokenMapping = Map<String, int>.from(jsonDecode(jsonString));
      tokenToCharMapping = charToTokenMapping.map((k, v) {
        print('index:$v, char:$k');
        return MapEntry(v, k);
      });
    } on PlatformException {
      print("only supported for android and ios so far");
    }
  }

  // softmax function. It turns a list of number into a probability
  // distribution which sum to one.
  // Definition:
  //    softmax([x1,x2,...,xn]) = [
  //      exp(x1)/(exp(x1)+exp(x2)+...+exp(xn)),
  //      exp(x2)/(exp(x1)+exp(x2)+...+exp(xn)),
  //      ...
  //      exp(xn)/(exp(x1)+exp(x2)+...+exp(xn))]
  List<double> _softmax(List<double> x) {
    List<double> xExp = x.map((xi) => exp(xi)).toList();
    double sum = xExp.reduce((double a, double b) => a + b);

    return xExp.map((xexpi) => (xexpi / sum)).toList();
  }

  // Generate multiple words given tokenized context.
  // The tokenContent is a list of number, each of which maps to certain
  // Mongolian basic character, e.g. 'ᠠ','ᠯ'. The mapping is defined in the
  // assets/mappings/char_to_token.json file.
  Future<Set<String>> _sample(
      List tokenContext, int wordMaxLength, int sampleNumber) async {
    var prediction = new Set<String>();
    // deep copy context to avoid accumulation
    List x = new List.from(tokenContext);

    // Make sure the context only look back maximum _blockSize number of
    // characters.
    if (x.length > this.blockSize) {
      x = x.sublist(x.length - this.blockSize, x.length);
    }

    // cast from int to double. This step could be removed for a better code
    // quality
    x = x.map((i) => (i.toDouble() as double)).toList();

    // Create sampleNumber of repeating words as the root for sampling
    var xMultiple = [];
    // Variable to track the status of word completeness
    var isComplete = [];

    // Initialization
    for (var i = 0; i < sampleNumber; i++) {
      xMultiple.add(new List.from(x));
      isComplete.add(false);
    }

    // Generate one character at a time until 'space' or 'new line' character
    // are generated for all words or wordMaxLength iteration is reached.
    for (var l = 0; l < wordMaxLength; l++) {
      // Check whether there is a completed word
      // The xMultiple and isComplete has to be updated accordingly when there
      // is any completed words
      // The xMultiple only contains words haven't been completed all the time.
      var xMultipleNew = [];
      for (var m = 0; m < xMultiple.length; m++) {
        //if yes, map word from token to string and add it to the result _prediction
        if (isComplete[m]) {
          var word = new List.from(xMultiple[m]);
          //map token to char and add it to the result _prediction
          prediction.add(word
              .map((token) => (tokenToCharMapping[token] as String))
              .toList()
              .join());
        }
        // otherwise, grow the word by one char again
        else {
          var newContext = xMultiple[m];

          // Truncate new context if it's longer than this.blocksize
          if (newContext.length > this.blockSize) {
            xMultipleNew.add(new List.from(newContext.sublist(
                newContext.length - this.blockSize, newContext.length)));
          } else {
            xMultipleNew.add(new List.from(newContext));
          }
        }
      }

      //prepare the new words to complete
      xMultiple = xMultipleNew;
      isComplete = [];
      for (var m = 0; m < xMultiple.length; m++) {
        isComplete.add(false);
      }

      //if all the words are complete, end the sampling procedure
      if (xMultiple.length == 0) {
        break;
      }
      //other wise sample one new char for each words that is not completed yet
      else {
        int currentWordLength = xMultiple[0].length;
        //prepare the input for model inference
        var xCondMultiple_1d = xMultiple.expand((i) => i).toList();
        xCondMultiple_1d =
            xCondMultiple_1d.map((i) => (i.toDouble() as double)).toList();

        // interact with the model and get the logits. Logits has shape
        // [xMultiple.length, xCond.length, _char_to_token.length] and it includes
        // the raw number that can be turned into probability for generating next
        // character.
        var logits = await _customModel.getPrediction(
            List<double>.from(xCondMultiple_1d),
            [xMultiple.length, currentWordLength],
            DType.int64);

        // we still sample one char from the 87 potential chars for each words
        // Todo:further speed up can be reached by vectorizing the softmax, random
        // number generation and sampling parts.
        for (var k = 1; k <= xMultiple.length; k++) {
          // only consider the last slide of the logits. Others are logits based on
          // shorter previous context.
          var logitsK = logits!.sublist(
              (k * currentWordLength - 1) * charToTokenMapping.length,
              k * currentWordLength * charToTokenMapping.length);

          // turn the logits into Probability Mass Function (PMF)
          List<double> probs = _softmax(List<double>.from(logitsK));

          // get the Cumulative Probability Mass Function (CMF). It is needed since I
          // don't know how to sample from a distribution in dart. The idea here is
          // to build a sampling tool based on a known CMF.
          probs[0] = probs[0] as double;
          for (var j = 1; j < probs.length; j++) {
            probs[j] = (probs[j - 1] + probs[j]) as double;
          }

          double randNum = rng.nextDouble();
          num ix = probs.indexWhere((p) => (p > randNum) as bool);

          // append the sampled new character to the context
          xMultiple[k - 1].add(ix.toDouble());
          // if a space or new line token is obtained, it means one word is
          // completed and we can record this in the isComplete list.
          if (ix == 0 || ix == 1) {
            isComplete[k - 1] = true;
          }
        }
      }
    }

    return prediction;
  }

  // Generate  number of auto completed words given the
  // context.
  Future<Set<String>> runCustomModel(String input) async {
    // refresh the old auto completions

    List tokenizedContext =
        input.split('').map((ch) => charToTokenMapping[ch] ?? 0).toList();
    tokenizedContext =
        tokenizedContext.map((i) => (i.toDouble() as double)).toList();

    // generate _numberOfSample number of auto completed words
    return await _sample(
        tokenizedContext, this.maxLengthOfWord, this.numberOfSampleWords);
  }
}
