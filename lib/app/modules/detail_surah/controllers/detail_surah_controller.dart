import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  //RxString kondisiAudio = "stop".obs;
  final player = AudioPlayer();

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://quran-api-id.vercel.app/surahs/$id");
    var res = await http.get(url);

    Map<String, dynamic> data = (json.decode(res.body) as Map<String, dynamic>);

    //print(data);
    return DetailSurah.fromJson(data);

    //Surah surahAnnas = Surah.fromJson(data[113]);
  }

  void stopAudio(Ayah ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      print("Error code, ${e.code}");
      print("Error Message, ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("Connection abourted, ${e.message}");
    } catch (e) {
      print(e);
    }
  }

  void pauseAudio(Ayah ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      print("Error code, ${e.code}");
      print("Error Message, ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("Connection abourted, ${e.message}");
    } catch (e) {
      print(e);
    }
  }

  void resumeAudio(Ayah ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      print("Error code, ${e.code}");
      print("Error Message, ${e.message}");
    } on PlayerInterruptedException catch (e) {
      print("Connection abourted, ${e.message}");
    } catch (e) {
      print(e);
    }
  }

  void playAudio(Ayah? ayat) async {
    if (ayat?.audio?.husarymujawwad != null) {
      try {
        await player.stop();
        await player.setUrl(ayat!.audio!.husarymujawwad);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        print("Error code, ${e.code}");
        print("Error Message, ${e.message}");
      } on PlayerInterruptedException catch (e) {
        print("Connection abourted, ${e.message}");
      } catch (e) {
        print(e);
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Url Audio tidak valid",
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
