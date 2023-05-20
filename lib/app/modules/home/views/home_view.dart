import 'package:alquran/app/constans/color.dart';
import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al Quran Apps'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCH),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalammualaikum",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    appPurpleLight1,
                    appPurpleLight2,
                  ]),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      width: Get.width,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -30,
                            right: 0,
                            child: Opacity(
                              opacity: 0.6,
                              child: Container(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  "assets/images/alquran.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      color: appWhite,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Terakhir di baca",
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Al Fatiha",
                                  style:
                                      TextStyle(color: appWhite, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Ayat 9",
                                  style:
                                      TextStyle(color: appWhite, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => TabBar(
                  indicatorColor: appPurpleDark,
                  labelColor:
                      controller.isDark.isTrue ? appWhite : appPurpleDark,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: "Surah",
                    ),
                    Tab(
                      text: "Juz",
                    ),
                    Tab(
                      text: "Bookmark",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                        future: controller.getAllSurah(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Surah surah = snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_SURAH,
                                        arguments: surah);
                                  },
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/list.png"),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${surah.number}",
                                      ),
                                    ),
                                  ),
                                  title: Text("${surah.name}"),
                                  subtitle: Text(
                                    "${surah.numberOfAyahs} Ayat | ${surah.revelation}",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  trailing: Text("${surah.translation}"),
                                );
                              });
                        }),
                    FutureBuilder<List<juz.Juzs>>(
                      future: controller.getAllJuz(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                            itemCount: 30,
                            itemBuilder: (context, index) {
                              juz.Juzs detailJuz = snapshot.data![index];
                              String nameStart =
                                  detailJuz.juzStartInfo?.split(" - ").first ??
                                      "";
                              String nameEnd =
                                  detailJuz.juzEndInfo?.split(" - ").first ??
                                      "";

                              List<Surah> rawAllSurahInJuz = [];
                              List<Surah> allSurahInJuz = [];

                              for (Surah item in controller.allSurah) {
                                rawAllSurahInJuz.add(item);
                                if (item.name == nameEnd) {
                                  break;
                                }
                              }

                              for (Surah item
                                  in rawAllSurahInJuz.reversed.toList()) {
                                allSurahInJuz.add(item);
                                if (item.name == nameStart) {
                                  break;
                                }
                              }
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                    "juz": detailJuz,
                                    "surah": allSurahInJuz.reversed.toList()
                                  });
                                },
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/list.png"),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                    ),
                                  ),
                                ),
                                title: Text("Juz ${index + 1}"),
                                isThreeLine: true,
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Mulai dari ${detailJuz.juzStartInfo}",
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    Text(
                                      "Sampai ${detailJuz.juzEndInfo}",
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    Center(child: Text("page 3")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeThemeMode(),
        child: Obx(
          () => Icon(
            Icons.color_lens,
            color: controller.isDark.isTrue ? appPurpleDark : appWhite,
          ),
        ),
      ),
    );
  }
}
