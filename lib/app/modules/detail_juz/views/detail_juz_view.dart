import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constans/color.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  const DetailJuzView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final juz.Juzs detailJuz = Get.arguments["juz"];
    final List<Surah> allSurahInJuz = Get.arguments["surah"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Juz ${detailJuz.juz}'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: detailJuz.verses?.length ?? 0,
        itemBuilder: (context, index) {
          if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
            return Center(
              child: Text("Tidak ada data!"),
            );
          }
          juz.Verses ayat = detailJuz.verses![index];
          if (index != 0) {
            if (ayat.number?.inSurah == 1) {
              controller.index++;
            }
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: appPurpleLight2.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/list.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Center(
                                  child: Text("${ayat.number?.inSurah}")),
                            ),
                            Text(
                              "${allSurahInJuz[controller.index].name ?? ''}",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark_add_outlined),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.play_arrow),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "${ayat?.text?.arab}",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "${ayat?.translation?.id}",
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
        },
      ),
    );
  }
}
