import 'dart:convert';

ProductModel productModelFromJson(String str) =>  ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String name;
  String image;
  double price;
  String description;
  String status;
  bool isFavourite;
  int? qty;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.status,
    required this.isFavourite,
    this.qty
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    price: double.parse(json["price"].toString()),
    description:json["description"].toString(),
    status: json["status"],
    qty:json["qty"],
    isFavourite: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": image,
    "price": price,
    "description": description,
    "status": status,
    "isFavourite":isFavourite,
    "qty":qty
  };
  @override
  ProductModel copyWith({
    int? qty,

  }) =>
      ProductModel(
        id: id,
        name:name,
        image: image,
        price:price,
        description:description,
        status:status,
        qty:qty??this.qty,
        isFavourite: isFavourite,
      );
}
