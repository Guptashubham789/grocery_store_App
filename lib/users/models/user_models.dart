// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) =>  UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String name;
  String? image;
  String email;
  String mobile;
  String address;
  String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.mobile,
    required this.password,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    mobile: json["mobile"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "mobile": mobile,
    "address": address,
    "image": image,
  };
  UserModel copyWith({
    String? name,mobile,address,image,
})=>
UserModel(
    id: id,
    name: name??this.name,
    email: email,
    address: address??this.address,
    mobile: mobile??this.mobile,
    image: image??this.image,
    password: password
);
}
