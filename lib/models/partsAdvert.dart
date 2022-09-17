import 'dart:convert';

List<PartsAdvert> partsFromJson(String str) =>
    List<PartsAdvert>.from(json.decode(str).map((dynamic x) {
      print(x["brand"]);
      return PartsAdvert.fromJson(x);
    }));

class PartsAdvert {
  late int id;
//  late int ownerId;
  late String dateCreate;
  late String type;
  late String brand;
  late String model;
  late String generation;
  late String nameOfPart;
  late String numberOfPart;
  late bool condition;
  late bool original;
  late String description;
  late int price;
  late String address;
  late String city;
  late int longitude;
  late int latitude;
  late bool isCompany;
  late String photo;
  late bool useEmail;
  late bool usePhone;
  late bool useWhatsapp;
  late bool archive;

  PartsAdvert(
      {required this.id,
      //  required this.ownerId,
      required this.dateCreate,
      required this.type,
      required this.brand,
      required this.model,
      required this.generation,
      required this.nameOfPart,
      required this.numberOfPart,
      //  required this.condition,
      required this.original,
      required this.description,
      required this.price,
      required this.address,
      required this.city,
      required this.longitude,
      required this.latitude,
      required this.isCompany,
      required this.photo,
      required this.useEmail,
      required this.usePhone,
      required this.useWhatsapp,
      required this.archive});

  PartsAdvert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // ownerId = json['ownerId'];
    dateCreate = json['dateCreate'];
    type = json['type'];
    brand = json['brand'];
    model = json['model'];
    generation = json['generation'];
    nameOfPart = json['nameOfPart'];
    numberOfPart = json['numberOfPart'];
    //condition = json['condition'];
    //original = json['original'];
    //description = json['description'];
    price = json['price'];
    address = json['address'];
    city = json['city'];
    //longitude = json['longitude'];
    // latitude = json['latitude'];
    // isCompany = json['isCompany'];
    photo = json['photo'];
    //useEmail = json['useEmail'];
    // usePhone = json['usePhone'];
    // useWhatsapp = json['use_whatsapp'];
    archive = json['archive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['ownerId'] = ownerId;
    data['dateCreate'] = dateCreate;
    data['type'] = type;
    data['brand'] = brand;
    data['model'] = model;
    data['generation'] = generation;
    data['nameOfPart'] = nameOfPart;
    data['numberOfPart'] = numberOfPart;
    data['condition'] = condition;
    data['original'] = original;
    data['description'] = description;
    data['price'] = price;
    data['address'] = address;
    data['city'] = city;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['isCompany'] = isCompany;
    data['photo'] = photo;
    data['useEmail'] = useEmail;
    data['usePhone'] = usePhone;
    data['use_whatsapp'] = useWhatsapp;
    data['archive'] = archive;
    return data;
  }
}
