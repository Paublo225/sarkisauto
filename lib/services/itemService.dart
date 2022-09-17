import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sarkisauto/models/itemModel.dart';
import 'package:sarkisauto/models/marksModel.dart';
import 'package:requests/requests.dart';
import 'package:sarkisauto/models/partsAdvert.dart';

class ItemServices {
  /*static Future<List<PartsAdvert>> fetchParts(String accessToken) async {
    final request = await http.get(
      Uri.parse(
          'https://realty.neirodev.ru/mehanik/partAnnouncements?types=PASSENGER&brands=HYUNDAI&brands=KIA&brands=TOYOTA&brands=BMW&pageNum=0&pageSize=10'),
      headers: {
        'Accept': 'application/json',
        'Cookie': 'access_token=$accessToken'
      },
    );
    if (request.statusCode == 200) {
      return partsFromJson(request.body);
    } else {
      throw Exception('Failed to load album');
    }
  }*/

  /*static createAdvert(String accessToken) async {
    Map<String, dynamic> parametrs = {
      "type": "PASSENGER",
      "brand": "HYUNDAI",
      "model": "E30",
      "generation": "string",
      "nameOfPart": "string",
      "numberOfPart": "2",
      "condition": "true",
      "original": "true",
      "description": "string",
      "price": "10000",
      "address": "г. Краснодар, улица Красная, 65",
      "city": "string",
      "longitude": "0",
      "latitude": "0",
      "isCompany": "true",
      "photo":
          "https://img.promportal.su/foto/good_fotos/3582/35820429/bampera-lom-b-u-brak-slomannie-kuplyu_foto_largest.jpg",
      "useEmail": "false",
      "usePhone": "true",
      "use_whatsapp": "true",
      "archive": "false"
    };
    Response response = await http.post(
      Uri.parse('https://realty.neirodev.ru/mehanik/partAnnouncements'),
      body: json.encode(parametrs),
      headers: {
  
        'Content-Type': 'application/json',
        'Cookie': 'access_token=$accessToken'
      },
    );
    print(response.statusCode);
    print(response.body);
  }*/

  static Future<List<PartsAdvert>> fetchParts(
      String accessToken, String carType) async {
    /*String types = "&types=";
    String brands = "";
    final req = await http.get(
      Uri.parse(
          'https://realty.neirodev.ru/mehanik/api/makes?carType=$carType'),
      headers: {'Accept': 'application/json'},
    );
    if (req.statusCode == 200) {
      // var body = json.encode(req.body);
      markFromJson(req.body).forEach((element) {
        brands += "&brands=${element.makeName}";
      });*/
    // print(brands);
    final request = await http.get(
      Uri.parse(
          'https://realty.neirodev.ru/mehanik/partAnnouncements?types=PASSENGER&brands=HYUNDAI&brands=KIA&brands=TOYOTA&brands=BMW&pageNum=0&pageSize=10'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Cookie': 'access_token=$accessToken'
      },
    );
    if (request.statusCode == 200) {
      print(request.json());
      return partsFromJson(json.encode(request.json()));
    } else {
      throw Exception('Failed to load ');
    }
  }
}
