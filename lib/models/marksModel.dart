import 'dart:convert';

import 'package:sarkisauto/models/itemModel.dart';

List<MarkModel> markFromJson(String str) => List<MarkModel>.from(
    json.decode(str).map((dynamic x) => MarkModel.fromJson(x)));

class MarkModel {
  int makeId;
  String makeName;
  MarkModel(this.makeId, this.makeName);

  factory MarkModel.fromJson(Map<String, dynamic> map) {
    return MarkModel(map['makeId'], map['makeName']);
  }
  Map<String, dynamic> toJson() {
    return {
      'makeId': makeId,
      'makeName': makeName,
    };
  }
}
