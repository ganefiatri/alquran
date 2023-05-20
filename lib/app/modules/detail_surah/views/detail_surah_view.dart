import 'package:alquran/app/constans/color.dart';
import 'package:alquran/app/data/models/detail_surah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  const DetailSurahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Surah surah = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah ${surah.name}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => Get.defaultDialog(
                title: "Tafsir ${surah.name}",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                middleText: "${surah.description}",
                middleTextStyle: TextStyle(),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      appPurpleLight1,
                      appPurpleLight2,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Surah ${surah.name}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: appWhite),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${surah.numberOfAyahs} Ayat | ${surah.revelation}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: appWhite),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<DetailSurah>(
                future: controller.getDetailSurah(surah.number.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Tidak ada data."),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?.ayahs.length ?? 0,
                      itemBuilder: (context, index) {
                        if (snapshot.data?.ayahs.length == 0) {
                          return SizedBox();
                        }
                        ;

                        var ayat = snapshot.data?.ayahs[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: appPurpleLight2.withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/list.png"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        child:
                                            Center(child: Text("${index + 1}")),
                                      ),
                                      GetBuilder<DetailSurahController>(
                                        builder: (c) => Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.bookmark_add_outlined),
                                            ),
                                            (ayat?.kondisiAudio == "stop")
                                                ? IconButton(
                                                    onPressed: () {
                                                      c.playAudio(ayat);
                                                    },
                                                    icon:
                                                        Icon(Icons.play_arrow),
                                                  )
                                                : Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      (ayat?.kondisiAudio ==
                                                              "playing")
                                                          ? IconButton(
                                                              onPressed: () {
                                                                c.pauseAudio(
                                                                    ayat!);
                                                              },
                                                              icon: Icon(
                                                                  Icons.pause),
                                                            )
                                                          : IconButton(
                                                              onPressed: () {
                                                                c.resumeAudio(
                                                                    ayat!);
                                                              },
                                                              icon: Icon(Icons
                                                                  .play_arrow),
                                                            ),
                                                      IconButton(
                                                        onPressed: () {
                                                          c.stopAudio(ayat!);
                                                        },
                                                        icon: Icon(Icons.stop),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "${ayat?.arab}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "${ayat?.translation}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
