import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'app/constans/color.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: box.read("themeDark") == null ? themeLight : themeDark,
      darkTheme: themeDark,
      title: "Application",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
