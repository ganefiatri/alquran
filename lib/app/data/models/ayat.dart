// https://quran-api-id.vercel.app/surahs/114/ayahs/1
//
// Detail per ayat;

import 'dart:convert';

Ayat ayatFromJson(String str) => Ayat.fromJson(json.decode(str));

String ayatToJson(Ayat data) => json.encode(data.toJson());

class Ayat {
  Number number;
  String arab;
  String translation;
  Audio audio;
  Image image;
  Tafsir tafsir;
  Meta meta;

  Ayat({
    required this.number,
    required this.arab,
    required this.translation,
    required this.audio,
    required this.image,
    required this.tafsir,
    required this.meta,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        number: Number.fromJson(json["number"]),
        arab: json["arab"],
        translation: json["translation"],
        audio: Audio.fromJson(json["audio"]),
        image: Image.fromJson(json["image"]),
        tafsir: Tafsir.fromJson(json["tafsir"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number.toJson(),
        "arab": arab,
        "translation": translation,
        "audio": audio.toJson(),
        "image": image.toJson(),
        "tafsir": tafsir.toJson(),
        "meta": meta.toJson(),
      };
}

class Audio {
  String alafasy;
  String ahmedajamy;
  String husarymujawwad;
  String minshawi;
  String muhammadayyoub;
  String muhammadjibreel;

  Audio({
    required this.alafasy,
    required this.ahmedajamy,
    required this.husarymujawwad,
    required this.minshawi,
    required this.muhammadayyoub,
    required this.muhammadjibreel,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        alafasy: json["alafasy"],
        ahmedajamy: json["ahmedajamy"],
        husarymujawwad: json["husarymujawwad"],
        minshawi: json["minshawi"],
        muhammadayyoub: json["muhammadayyoub"],
        muhammadjibreel: json["muhammadjibreel"],
      );

  Map<String, dynamic> toJson() => {
        "alafasy": alafasy,
        "ahmedajamy": ahmedajamy,
        "husarymujawwad": husarymujawwad,
        "minshawi": minshawi,
        "muhammadayyoub": muhammadayyoub,
        "muhammadjibreel": muhammadjibreel,
      };
}

class Image {
  String primary;
  String secondary;

  Image({
    required this.primary,
    required this.secondary,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        primary: json["primary"],
        secondary: json["secondary"],
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary,
      };
}

class Meta {
  int juz;
  int page;
  int manzil;
  int ruku;
  int hizbQuarter;
  Sajda sajda;

  Meta({
    required this.juz,
    required this.page,
    required this.manzil,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: Sajda.fromJson(json["sajda"]),
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda.toJson(),
      };
}

class Sajda {
  bool recommended;
  bool obligatory;

  Sajda({
    required this.recommended,
    required this.obligatory,
  });

  factory Sajda.fromJson(Map<String, dynamic> json) => Sajda(
        recommended: json["recommended"],
        obligatory: json["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

class Number {
  int inQuran;
  int inSurah;

  Number({
    required this.inQuran,
    required this.inSurah,
  });

  factory Number.fromJson(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class Tafsir {
  Kemenag kemenag;
  String quraish;
  String jalalayn;

  Tafsir({
    required this.kemenag,
    required this.quraish,
    required this.jalalayn,
  });

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        kemenag: Kemenag.fromJson(json["kemenag"]),
        quraish: json["quraish"],
        jalalayn: json["jalalayn"],
      );

  Map<String, dynamic> toJson() => {
        "kemenag": kemenag.toJson(),
        "quraish": quraish,
        "jalalayn": jalalayn,
      };
}

class Kemenag {
  String short;
  String long;

  Kemenag({
    required this.short,
    required this.long,
  });

  factory Kemenag.fromJson(Map<String, dynamic> json) => Kemenag(
        short: json["short"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };
}
