import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';

typedef WordTapCallback = void Function(String);

class WordSuggestionsSection extends StatelessWidget {
  final double height;
  final List<String> words;
  final WordTapCallback onWordTap;
  const WordSuggestionsSection(
      {Key? key,
      required this.words,
      required this.onWordTap,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: words.length,
        itemBuilder: (context, int i) {
          var e = words[i];
          return InkWell(
            onTap: () {
              onWordTap(e);
            },
            child: Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: MongolText(
                  e,
                  style: TextStyle(fontFamily: 'haratig', fontSize: 24),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
