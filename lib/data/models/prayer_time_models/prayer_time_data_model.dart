// To parse this JSON data, do
//
//     final prayerTimeDataModel = prayerTimeDataModelFromJson(jsonString);

import 'dart:convert';

PrayerTimeDataModel prayerTimeDataModelFromJson(String str) => PrayerTimeDataModel.fromJson(json.decode(str));

String prayerTimeDataModelToJson(PrayerTimeDataModel data) => json.encode(data.toJson());

class PrayerTimeDataModel {
  Data ? data;
  String ? status;
  int ? code;

  PrayerTimeDataModel({
     this.data,
     this.status,
     this.code,
  });

  factory PrayerTimeDataModel.fromJson(Map<String, dynamic> json) => PrayerTimeDataModel(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "status": status,
    "code": code,
  };
}

class Data {
  Timings timings;

  Data({
    required this.timings,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    timings: Timings.fromJson(json["timings"]),
  );

  Map<String, dynamic> toJson() => {
    "timings": timings.toJson(),
  };
}

class Timings {
  String dhuhr;
  String sunrise;
  String maghrib;
  String imsak;
  String isha;
  String lastthird;
  String firstthird;
  String midnight;
  String fajr;
  String asr;
  String sunset;

  Timings({
    required this.dhuhr,
    required this.sunrise,
    required this.maghrib,
    required this.imsak,
    required this.isha,
    required this.lastthird,
    required this.firstthird,
    required this.midnight,
    required this.fajr,
    required this.asr,
    required this.sunset,
  });

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
    dhuhr: json["Dhuhr"],
    sunrise: json["Sunrise"],
    maghrib: json["Maghrib"],
    imsak: json["Imsak"],
    isha: json["Isha"],
    lastthird: json["Lastthird"],
    firstthird: json["Firstthird"],
    midnight: json["Midnight"],
    fajr: json["Fajr"],
    asr: json["Asr"],
    sunset: json["Sunset"],
  );

  Map<String, dynamic> toJson() => {
    "Dhuhr": dhuhr,
    "Sunrise": sunrise,
    "Maghrib": maghrib,
    "Imsak": imsak,
    "Isha": isha,
    "Lastthird": lastthird,
    "Firstthird": firstthird,
    "Midnight": midnight,
    "Fajr": fajr,
    "Asr": asr,
    "Sunset": sunset,
  };
}
