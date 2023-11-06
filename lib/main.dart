import 'package:flutter/material.dart';
import 'package:flutter_balance_game_client/app.dart';
import 'package:flutter_balance_game_client/route/app_pages.dart';
import 'package:flutter_balance_game_client/theme/app_thene.dart';
import 'package:get/get.dart';
void main() {

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    initialRoute: Routes.initial,
  )
  );
}