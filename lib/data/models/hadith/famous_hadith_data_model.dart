// To parse this JSON data, do
//
//     final famousHadithDataModel = famousHadithDataModelFromJson(jsonString);

import 'dart:convert';

FamousHadithDataModel famousHadithDataModelFromJson(String str) => FamousHadithDataModel.fromJson(json.decode(str));

String famousHadithDataModelToJson(FamousHadithDataModel data) => json.encode(data.toJson());

class FamousHadithDataModel {
  String ? message;
  List<Hadise> ? hadises;

  FamousHadithDataModel({
     this.message,
     this.hadises,
  });

  factory FamousHadithDataModel.fromJson(Map<String, dynamic> json) => FamousHadithDataModel(
    message: json["message"],
    hadises: List<Hadise>.from(json["hadises"].map((x) => Hadise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "hadises": List<dynamic>.from(hadises!.map((x) => x.toJson())),
  };
}

class Hadise {
  int id;
  String hadis;
  String hadisTranslate;
  String hadisDescription;
  String reference;
  String audioLink;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String isFavorite;
  String isChecked;
  String note;

  Hadise({
    required this.id,
    required this.hadis,
    required this.hadisTranslate,
    required this.hadisDescription,
    required this.reference,
    required this.audioLink,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
    required this.isChecked,
    required this.note,
  });

  factory Hadise.fromJson(Map<String, dynamic> json) => Hadise(
    id: json["id"],
    hadis: json["hadis"],
    hadisTranslate: json["hadis_translate"],
    hadisDescription: json["hadis_description"],
    reference: json["reference"],
    audioLink: json["audio_link"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isFavorite: json["is_favorite"],
    isChecked: json["is_checked"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hadis": hadis,
    "hadis_translate": hadisTranslate,
    "hadis_description": hadisDescription,
    "reference": reference,
    "audio_link": audioLink,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_favorite": isFavorite,
    "is_checked": isChecked,
    "note": note,
  };
}
