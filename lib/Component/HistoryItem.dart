import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mongol/mongol.dart';
import 'package:zmongol/Model/CustomizableText.dart';
import 'package:zmongol/Model/HistoryImage.dart';

class HistoryItem extends StatefulWidget {
  final HistoryImage historyImage;
  final Function onItemPressed;
  final SlidableController slidableController;
  final Function onItemDeleted;

  const HistoryItem(
  this.historyImage,
  this.slidableController,
      {
        required this.onItemPressed,
        required this.onItemDeleted
      });

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

  deleteItem() async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete item'),
        content: Text('Do you want to delete this image?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          TextButton(onPressed: () {
            widget.onItemDeleted();
            Get.back();
          }, child: Text('Delete')),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Slidable(
        controller: widget.slidableController,
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.3,
        secondaryActions: [
          GestureDetector(
            onTap: deleteItem,
            child: Container(
                height: 100,
                margin: EdgeInsets.only(left: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red),
                child: Text(
                    'Delete',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white)
                )),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            widget.onItemPressed();
          },
          child: Container(
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
        ),
      ),
    );
  }
}
