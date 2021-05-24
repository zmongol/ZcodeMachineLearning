import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mongol/mongol.dart';
import 'package:zmongol/Component/CustomizableText.dart';
import 'package:zmongol/Component/HistoryImage.dart';
import 'package:zmongol/EditImagePage.dart';
import 'package:zmongol/Utils/HistoryHelper.dart';

class HistoryItem extends StatefulWidget {
  final HistoryImage historyImage;

  const HistoryItem(this.historyImage);

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  late File imageFile;
  late DateTime date;
  late List<CustomizableText> texts;

  @override
  void initState() {
    imageFile = File(widget.historyImage.filePath);
    date = DateTime.parse(widget.historyImage.dateTime);
    getHistoryTexts();
    super.initState();
  }

  getHistoryTexts() async {
    texts = await HistoryHelper.instance.getTextsByImageId(widget.historyImage.id!);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(EditImagePage(imageFile, historyTexts: texts));
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
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
              child: Image.file(imageFile, fit: BoxFit.contain),
            ),
            SizedBox(width: 32),
            MongolText(
                DateFormat('yyyy-MM-dd').format(date)
            )
          ],
        ),
      ),
    );
  }
}
