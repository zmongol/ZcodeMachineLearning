import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';

/// 截屏图片生成图片流ByteData
Future<ByteData?> _capturePngToByteData(key) async {
  try {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    ui.Image image = await boundary.toImage(pixelRatio: dpr);
    ByteData? _byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (_byteData != null) {
      return _byteData;
    }
  } catch (e) {
    print(e);
  }
}

/// 把图片ByteData写入File，
Future<Null> shareUiImage(key) async {
  ByteData? sourceByteData = await _capturePngToByteData(key);
  if (sourceByteData != null) {
    Uint8List sourceBytes = sourceByteData.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();

    String storagePath = tempDir.path;
    File file = await File('$storagePath/zmongol.png').create();

    await file.writeAsBytes(sourceBytes);
    Share.shareFiles(['$storagePath/zmongol.png'], text: 'Great picture');
  }
}

//todo保存图片到相册
Future<Uint8List?> saveToGallery(key) async {
  // return;
  ByteData? sourceByteData = await _capturePngToByteData(key);
  if (sourceByteData != null) {
    Uint8List sourceBytes = sourceByteData.buffer.asUint8List();
    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isBlank!) {
        Map<Permission, PermissionStatus> statuses = await [Permission.photos,].request();
        saveToGallery(key);
      }
      if (status.isGranted || status.isLimited) {
        final result = await ImageGallerySaver.saveImage(sourceBytes, quality: 60, name: "hello");
        if (result!=null) {
          return sourceBytes;
          print('ok');
          Get.snackbar('successfully', 'saved');
        } else {
          print('error');
          Get.snackbar('failed','');
        }
      }
      if (status.isDenied) {
        print("IOS拒绝");
      }
    } else if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status.isBlank!) {
        Map<Permission, PermissionStatus> statuses = await [Permission.storage].request();
        saveToGallery(key);
      }
      if (status.isGranted) {
        print("Android已授权");
        final result = await ImageGallerySaver.saveImage(sourceBytes, quality: 60);
        if (result != null) {
          return sourceBytes;
          print('ok');
          Get.snackbar('save to gallery success', 'save to gallery success', snackPosition: SnackPosition.BOTTOM);
        } else {
          print('error');
        }
      }
      if (status.isDenied) {
        print("Android拒绝");
      }
    }
  }
}

//微信分享
// fluwx.shareToWeChat(fluwx.WeChatShareImageModel.fromFile(
// shareEvent.file,
// description: shareEvent.desc,
// scene: scene));
