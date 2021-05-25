import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:zmongol/Controller/StyleController.dart';
import 'package:zmongol/Controller/TextController.dart';
import 'package:zmongol/Screen/StartPage.dart';
import 'package:zmongol/Utils/HistoryHelper.dart';

import 'Component/MongolFonts.dart';
import 'Controller/KeyboardController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
  //     .then((value) => runApp(MyApp()));
  Get.put<KeyboardController>(KeyboardController());

  Get.put<StyleController>(StyleController());

  Get.put<TextStyleController>(TextStyleController());
  Get.put<TextStyleController>(TextStyleController(), tag: 'border_style');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      allowFontScaling: false,
      builder: () => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: MongolFonts.haratig),
        // home: TextEditPage(title: 'zcode'),
        home: StartPage(),
      ),
    );
  }
}
