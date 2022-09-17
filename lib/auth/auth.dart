// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:requests/requests.dart';
import 'package:sarkisauto/helpers/pageRoute.dart';
import 'package:sarkisauto/helpers/style.dart';
import 'package:sarkisauto/homePage/homePage.dart';
import 'package:sarkisauto/services/authService.dart';

class AuthPage extends StatefulWidget {
  AuthPage();
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String textData =
      "Для размещения объявления необходимо зарегестрироваться или авторизироваться";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: SizedBox(),
      ),
      body: Column(children: [
        Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 150),
            child: Text(
              textData,
              textAlign: TextAlign.center,
              style: authStyle,
            )),
        Container(
            margin: EdgeInsets.only(bottom: 50, top: 30, left: 30, right: 30),
            child: inputPhone()),
        GestureDetector(
            onTap: () {
              AuthServices.sendCode('8$phone').then((value) {
                if (value == 200) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (builder) => CodePage(
                                phone: '8$phone',
                              )));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Ошибка $value")));
                }
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 44, right: 44),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Center(
                  child: Text(
                "Получить код",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )),
            ))
      ]),
    );
  }

  String phone = "";
  Widget inputPhone() {
    List<TextEditingController> controller =
        List.generate(10, (i) => TextEditingController());

    return Form(
        onChanged: (() {}),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Text(
                "+7",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              child: Text(
                "(",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              width: 25,
              height: 25,
              child: TextField(
                controller: controller[0],
                onChanged: ((value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                }),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            SizedBox(
              width: 25,
              height: 25,
              child: TextField(
                controller: controller[1],
                onChanged: ((value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                }),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            SizedBox(
              width: 25,
              height: 25,
              child: TextField(
                controller: controller[2],
                onChanged: ((value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                }),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            SizedBox(
              child: Text(
                ")",
                style: TextStyle(fontSize: 25),
              ),
            ),
            for (int i = 3; i < controller.length; i++)
              SizedBox(
                width: 25,
                height: 25,
                child: TextField(
                  controller: controller[i],
                  onChanged: ((value) {
                    phone = "";
                    for (var element in controller) {
                      phone += element.text;
                    }

                    if (value.length == 1 && phone.length < 10) {
                      FocusScope.of(context).nextFocus();
                    }
                  }),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              )
          ],
        ));
  }
}

class CodePage extends StatefulWidget {
  String phone;
  CodePage({required this.phone});
  @override
  _CodePageState createState() => new _CodePageState();
}

class _CodePageState extends State<CodePage> {
  String textData = "Мы отправили СМС с 4-х значным кодом на ваш номер";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
                color: Colors.transparent,
                width: 50,
                height: 50,
                child: const Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                ))),
      ),
      body: Column(children: [
        Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 150),
            child: Text(
              textData,
              textAlign: TextAlign.center,
              style: authStyle,
            )),
        Container(margin: EdgeInsets.all(114), child: inputCode()),
        GestureDetector(
            onTap: () async {
              await AuthServices.registerUser(widget.phone, code).then((value) {
                print(value.json()["accessToken"]);
                if (value.statusCode == 200) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(mainColor),
                          ),
                        );
                      });
                  int timeout = 3000;

                  Timer? timer =
                      Timer(Duration(milliseconds: timeout), () async {
                    Navigator.pop(context);
                    await Navigator.pushAndRemoveUntil(
                        context,
                        NoAnimationMaterialPageRoute(
                          builder: (context) => HomePage(
                            accessCode: value.json()["accessToken"],
                          ),
                        ),
                        (route) => false);
                  });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Ошибка $value")));
                }
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                left: 44,
                right: 44,
              ),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Center(
                  child: Text(
                "Ввести код",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )),
            ))
      ]),
    );
  }

  String code = "";
  Widget inputCode() {
    List<TextEditingController> controller =
        List.generate(4, (i) => TextEditingController());
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < controller.length; i++)
          SizedBox(
            width: 25,
            height: 25,
            child: TextField(
              controller: controller[i],
              onChanged: ((value) {
                code = "";
                for (var element in controller) {
                  code += element.text;
                }

                if (value.length == 1 && code.length < 4) {
                  FocusScope.of(context).nextFocus();
                }
              }),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
      ],
    ));
  }
}
