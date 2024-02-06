// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

SlidersModel slidersModelFromJson(String str) =>  SlidersModel.fromJson(json.decode(str));
String slidersModelToJson(SlidersModel data) => json.encode(data.toJson());

class SlidersModel {
  String id;

  String image;

  SlidersModel({
    required this.id,
    required this.image,
  });

  factory SlidersModel.fromJson(Map<String, dynamic> json) => SlidersModel(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
