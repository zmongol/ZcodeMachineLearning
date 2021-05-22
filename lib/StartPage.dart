import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:zmongol/EditorPage.dart';import 'Component/MongolFonts.dart';
import 'EditImagePage.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

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
        Get.to(() => EditImagePage(croppedFile));
      }
    } else {
      print('No image selected.');
    }
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
            padding: EdgeInsets.all(48),
            child: Column(
              children: [
                Row(
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
                ),
                Container(

                )
              ],
            ),
          ),
        ),
    );
  }
}
