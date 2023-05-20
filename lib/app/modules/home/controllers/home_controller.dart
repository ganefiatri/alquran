import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:alquran/app/data/models/juz.dart';
import 'package:get/get.dart';
//import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

import '../../../constans/color.dart';

class HomeController extends GetxController {
  List<Surah> allSurah = [];
  RxBool isDark = false.obs;

  void changeThemeMode() async {
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);
    isDark.toggle();

    final box = GetStorage();
    if (Get.isDarkMode) {
      box.remove("themeDark");
    } else {
      box.write("themeDark", true);
    }
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://quran-api-id.vercel.app/surahs");
    var res = await http.get(url);

    List? data = (json.decode(res.body));

    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();

      return allSurah;
    }

    //Surah surahAnnas = Surah.fromJson(data[113]);
  }

  Future<List<Juzs>> getAllJuz() async {
    List<Juzs> allJuz = [];
    for (int i = 1; i <= 30; i++) {
      Uri url = Uri.parse("https://api.quran.gading.dev/juz/$i");
      var res = await http.get(url);

      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>)["data"];

      Juzs juz = Juzs.fromJson(data);
      allJuz.add(juz);

      //Surah surahAnnas = Surah.fromJson(data[113]);
    }
    return allJuz;
  }
}
