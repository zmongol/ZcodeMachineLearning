import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongol/mongol.dart';
import 'package:zmongol/Model/CustomizableText.dart';
import 'package:zmongol/Model/HistoryImage.dart';

class HistoryItem extends StatefulWidget {
  final HistoryImage historyImage;
  final Function onItemPressed;

  const HistoryItem(this.historyImage, this.onItemPressed);

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  late List<CustomizableText> texts;

  @override
  void initState() {
    super.initState();
  }

  getImageData() {
    File imageFile = File(widget.historyImage.previewFilePath ?? widget.historyImage.filePath);
    return imageFile.readAsBytesSync();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onItemPressed();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.white),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 12.0,
                spreadRadius: 2.0,
                offset: Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                image: DecorationImage(
                  image: MemoryImage(getImageData()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 32),
            MongolText(
                DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.historyImage.dateTime))
            )
          ],
        ),
      ),
    );
  }
}
