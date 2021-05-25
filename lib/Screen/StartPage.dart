import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:zmongol/Component/LoadingIndicator.dart';
import 'package:zmongol/Model/CustomizableText.dart';
import 'package:zmongol/Model/HistoryImage.dart';
import 'package:zmongol/Component/HistoryItem.dart';
import 'package:zmongol/Screen/EditorPage.dart';import '../Component/MongolFonts.dart';
import 'EditImagePage.dart';
import '../Utils/HistoryHelper.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with WidgetsBindingObserver {
  List<HistoryImage> historyImages = [];
  bool isLoading = false;

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      if (state == AppLifecycleState.resumed) {
        getHistory();
      }
    });
  }

  showLoadingView() {
    setState(() {isLoading = true;});
  }

  hideLoadingView() {
    setState(() {isLoading = false;});
  }

  _selectPhoto() async {
    File image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.indigo,
              toolbarWidgetColor: Colors.white,
              // activeControlsWidgetColor: Colors.blue,
              initAspectRatio:
              CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedFile != null) {
        await Get.to(() => EditImagePage(croppedFile));
        getHistory();
      }
    } else {
      print('No image selected.');
    }
  }

  getHistory() async {
    showLoadingView();
    await HistoryHelper.instance.open();
    historyImages = [];
    historyImages = await HistoryHelper.instance.getImages();
    hideLoadingView();
  }

  optionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            _selectPhoto();
          },
          child: Container(
            margin: EdgeInsets.all(4),
            width: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(4)),
            child: Container(
              height: 150,
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: RotatedBox(
                quarterTurns: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'ᡬᡬᢞᡭᢇ ᢔᡭᡪᢊᡱᡱᡭᡪᡪᡳ',
                      style: TextStyle(fontSize: 24)
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(EditorPage(editWithImage: false));
          },
          child: Container(
            margin: EdgeInsets.all(4),
            width: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(4)),
            child: Container(
              height: 150,
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: RotatedBox(
                quarterTurns: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'ᡥᡭᡬᢔᡭᡬᡨ ᡳᡬᢚᡬᢋᡭ',
                      style: TextStyle(fontSize: 24)
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  historyView() {
    List<Widget> widgets = [];
    SlidableController slidableController = SlidableController();
    historyImages.forEach((element) {
      HistoryItem item = HistoryItem(
        element,
        slidableController,
        onItemPressed: () async {
          showLoadingView();
          List<CustomizableText> texts = await HistoryHelper.instance.getTextsByImageId(element.id!);
          hideLoadingView();
          await Get.to(() => EditImagePage(File(element.filePath), historyTexts: texts));
          getHistory();
        },
        onItemDeleted: () async {
          await HistoryHelper.instance.deleteImage(element);
          setState(() {
            getHistory();
          });
        }
      );
      widgets.add(item);
    });

    return Expanded(
      child: Stack(
        children: [
          ListView(
              children: widgets
          ),
          isLoading ? LoadingIndicator() : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title:  Text(
                'Z ᢌᡭᡪᢊᡱᡱᡭᢐ',
                style: TextStyle(fontFamily: MongolFonts.haratig)
              ),
              centerTitle: true,
              backgroundColor: Colors.indigo,
          ),
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: Container(
              child: Column(
                children: [
                  optionButtons(),
                  SizedBox(height: 40),
                  historyView(),
                ],
              ),
            ),
          ),
        ),
    );
  }
}