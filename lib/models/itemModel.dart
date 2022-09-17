import 'dart:convert';

List<ItemModel> productFromJson(String str) =>
    List<ItemModel>.from(json.decode(str).map((dynamic x) {
      return ItemModel.fromJson(x);
    }));

class ItemModel {
  ItemModel({
    required this.id,
    required this.address,
    required this.archive,
    required this.brand,
    required this.city,
    required this.dateCreate,
    required this.generation,
    required this.latitude,
    required this.longitude,
    required this.model,
    required this.nameOfPart,
    required this.numberOfPart,
    required this.photo,
    required this.price,
    required this.type,
  });
  int id;
  String type;
  String brand;
  String model;
  String generation;
  String nameOfPart;
  String numberOfPart;
  String city;
  String photo;
  String address;
  int price;
  String dateCreate;
  bool archive;
  int latitude;
  int longitude;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'],
      address: json['address'],
      archive: json['archive'],
      brand: json['brand'],
      city: json['city'],
      dateCreate: json['dateCreate'],
      generation: json['eneration'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      model: json['model'],
      nameOfPart: json['nameOfPart'],
      numberOfPart: json['numberOfPart'],
      photo: json['photo'],
      price: json['price'],
      type: json['type']);

  /* Map<String, dynamic> toJson() => {
        "id": 0,
        "type": "string",
        "brand": "string",
        "model": "string",
        "generation": "string",
        "nameOfPart": "string",
        "numberOfPart": "string",
        "city": "string",
        "photo": "string",
        "address": "string",
        "price": 0,
        "dateCreate": "2022-09-14T20:49:45.121Z",
        "archive": true,
        "latitude": 0,
        "longitude": 0
      };*/
}
