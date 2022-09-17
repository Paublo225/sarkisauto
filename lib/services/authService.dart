import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:requests/requests.dart';

class AuthServices {
  static const String apiKey = "en6h34H*dfnUY56awF7(wergRty_r7TYN";
  static Future<Response> registerUser(String phone, String code) async {
    final reqest = await Requests.post(
      'https://realty.neirodev.ru/mehanik/auth/confirm?phone=$phone&code=$code',
      headers: {'Accept': '*/*', 'Content-type': 'text/plain; charset=utf-8'},
    );
    return reqest;
  }

  static Future aboutMe() async {
    final reqest = await Requests.get(
      'https://realty.neirodev.ru/mehanik/users/me',
      headers: {'Accept': '*/*', 'Content-type': 'text/plain; charset=utf-8'},
    );
    print(reqest.body);
  }

  static Future sendCode(String phone) async {
    final reqest = await Requests.post(
      'https://realty.neirodev.ru/mehanik/auth/register?phone=$phone&secret=$apiKey',
      headers: {
        'Accept': 'application/json',
        'Content-type': 'text/html; charset=utf-8'
      },
    );
    return reqest.statusCode;
  }
}
