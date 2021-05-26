import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mongol/mongol.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zmongol/Model/CustomizableText.dart';
import 'package:zmongol/Model/HistoryImage.dart';
import 'package:zmongol/Utils/HistoryHelper.dart';

import 'MongolFonts.dart';

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
  bool isPlankImage = false;

  @override
  void initState() {
    super.initState();
    isPlankImage = widget.historyImage.filePath == null;
  }

  Uint8List getImageData() {
    if (!isPlankImage) {
      File imageFile = File((widget.historyImage.previewFilePath ?? widget.historyImage.filePath!));
      return imageFile.readAsBytesSync();
    }
    if (widget.historyImage.previewFilePath != null) {
      File imageFile = File((widget.historyImage.previewFilePath!));
      return imageFile.readAsBytesSync();
    } else {
      return kTransparentImage;
    }
  }

  deleteItem() async {
    Get.dialog(MongolAlertDialog(
      title: MongolText(
          'ᡥᡪᡪᢊᡪᡪᡪᢞᡪᡪᡳ',
          style: TextStyle(color: Colors.red, fontSize: 32, fontFamily: MongolFonts.haratig)
      ),
      content: MongolText('ᡴᡭᡬᢋᡭᡧ ᡫ ᡥᡪᢞᢚᡬᡪᡪᡳ ᡭᡳ ᡓ',
          style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: MongolFonts.haratig)
      ),
      actions: <Widget>[
        // NOTE: cancel button
        TextButton(
          child: MongolText(
            'ᡴᡭᢚᡪᡰᡨ',
            style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: MongolFonts.haratig),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        //NOTE: delete button
        TextButton(
          child: MongolText(
            'ᡥᡪᢞᢚᡬᡰᡨ',
            style: TextStyle(color: Colors.red, fontSize: 20, fontFamily: MongolFonts.haratig),
          ),
          onPressed: () {
            widget.onItemDeleted();
            Get.back();
          },
        ),
      ],
    ));
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
                    color: Colors.red
                ),
                child: MongolText(
                    'ᡥᡪᢞᢚᡬᡰᡨ',
                    style: TextStyle(fontSize: 16, color: Colors.white)
                )
            ),
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
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(0, 3)
                ),
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
