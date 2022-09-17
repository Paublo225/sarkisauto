// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sarkisauto/helpers/style.dart';
import 'package:sarkisauto/models/itemModel.dart';
import 'package:sarkisauto/models/partsAdvert.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemScreen extends StatefulWidget {
  PartsAdvert itemModel;
  String dateCreate;

  ItemScreen({required this.itemModel, required this.dateCreate});
  _ItemScreenState createState() => new _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  Color dividerColor = Color.fromRGBO(18, 18, 18, 1);
  Color shadowContainer = Color.fromRGBO(0, 0, 0, 0.05);
  Future<void>? _launched;
  String whatsAppNumber = "+79615335945";
  String number = "89615335945";
  String whatsAppText = "Здарова";

  String contactEmail = "pavelgr4@outlook.com";
  Future<void> _openUrl() async {
    Uri url = Uri(scheme: 'tel', path: number);

    await launchUrl(url);
  }

  openwhatsapp() async {
    var whatsappURlandroid =
        "whatsapp://send?phone=$whatsAppNumber&text=$whatsAppText";
    var whatappURLios =
        "https://wa.me/${whatsAppNumber.toString()}/?text=${Uri.encodeFull(whatsAppText)}";

    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(whatappURLios))) {
        await launchUrl(Uri.parse(whatappURLios));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("What's app не установлен")));
      }
    } else {
      if (await canLaunchUrl(Uri.parse(whatsappURlandroid))) {
        await launchUrl(Uri.parse(whatsappURlandroid));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("What's app не установлен")));
      }
    }
  }

  String? price;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    price = widget.itemModel.price.toString();
    if (price!.length > 2) {
      price = price!.substring(0, 2) + " " + price!.substring(2, price!.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                CupertinoIcons.share,
                color: Color.fromRGBO(71, 164, 242, 1),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                CupertinoIcons.heart,
                color: Color.fromRGBO(71, 164, 242, 0.5),
              )
            ],
          ),
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
        body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // alignment: Alignment.center,
                    width: double.infinity,
                    height: 300,
                    //   margin: EdgeInsets.all(16),
                    child: Image.network(
                      widget.itemModel.photo,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(
                          widget.itemModel.nameOfPart,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      )),
                  Container(
                    child: Text(
                      "$price Р",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(
                          widget.itemModel.address,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Показать на карте",
                      style: const TextStyle(
                        color: mainColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  specification('Дата публикации', widget.dateCreate),
                  specification('Поколение', widget.itemModel.generation),
                  specification('Модель', widget.itemModel.model),
                  specification('Количество', widget.itemModel.numberOfPart),
                  specification('Брэнд', widget.itemModel.brand),
                  Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                  sellerContact(),
                  messageButtons(),
                  rateSeller(),
                  Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        "СТО которые вам помогут:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromRGBO(18, 18, 18, 0.9)),
                      )),
                  sto(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: carouselPoints(10, 0)),
                  expandedText("Похожие объявления"),
                  expandedText("Автомойки"),
                  expandedText("Шиномонтаж"),
                ],
              )),
        ));
  }

  Widget specification(String name, String value) {
    final EdgeInsets pad = EdgeInsets.only(bottom: 16);
    return Padding(
      padding: pad,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: Text(
          name,
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat',
            fontSize: 12,
          ),
        )),
        Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(18, 18, 18, 0.9),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            )),
      ]),
    );
  }

  Widget sellerContact() {
    final EdgeInsets pad = EdgeInsets.only(top: 24, bottom: 24);
    return Container(
      height: 100,
      width: double.infinity,
      margin: pad,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: shadowContainer, blurRadius: 10, offset: Offset(0, 5))
          ]),
      child: Row(children: [
        Padding(
            padding: EdgeInsets.only(left: 30),
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 25,
            )),
        Padding(
            padding: EdgeInsets.only(left: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Павел Григорян",
                      style: TextStyle(fontSize: 12),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Частное лицо",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "7 объявлений",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(left: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 12),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerRight,
                    child: RatingBar.builder(
                      initialRating: 3,
                      itemSize: 15,

                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ),
              ],
            )),
      ]),
    );
  }

  Widget messageButtons() {
    Color whatsAppColor = Color.fromRGBO(0, 230, 118, 1);
    Color callNumberColor = Color.fromRGBO(71, 164, 242, 1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () => openwhatsapp(),
            child: Container(
              //  margin: EdgeInsets.only(left: 16),
              height: 36,
              width: 165,
              decoration: BoxDecoration(
                  color: whatsAppColor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/assets/Vector-5.png'),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "НАПИСАТЬ",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            )),
        GestureDetector(
            onTap: () => _openUrl(),
            child: Container(
              // margin: EdgeInsets.only(right: 16),
              height: 36,
              width: 165,
              decoration: BoxDecoration(
                  color: callNumberColor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('lib/assets/Vector-6.png'),
                  SizedBox(
                    width: 8,
                  ),
                  Text("ПОЗВОНИТЬ",
                      style: TextStyle(color: Colors.white, fontSize: 12))
                ],
              ),
            ))
      ],
    );
  }

  Widget rateSeller() {
    return Container(
        margin: EdgeInsets.only(top: 30, bottom: 30),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "Оцените продавца",
              style: TextStyle(fontSize: 18),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              // alignment: Alignment.centerRight,
              child: RatingBar.builder(
                initialRating: 5,
                itemSize: 30,

                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star_border_outlined,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
          ],
        ));
  }

  Widget sto() {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            height: 137,
            width: 155,
            color: Colors.grey,
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'СТО "Гарант+"',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Container(
                  width: double.infinity - 155,
                  padding: EdgeInsets.only(top: 8),
                  child: Divider(
                    height: 1,
                    color: Color.fromRGBO(196, 196, 196, 1),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Wrap(children: [
                    Text(
                      'Республика Адыгея, г. Майкоп, Пролетарска 7',
                      maxLines: 4,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ])),
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 10),
                // alignment: Alignment.centerRight,
                child: RatingBar.builder(
                  initialRating: 4.5,
                  itemSize: 10,

                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Color.fromRGBO(18, 18, 18, 0.3),
                      size: 16,
                    ),
                    Text(
                      "5 км от Вас",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          fontSize: 10,
                          color: Color.fromRGBO(18, 18, 18, 0.3)),
                    )
                  ],
                ),
              )
            ]),
          ))
        ],
      ),
    );
  }

  Widget expandedText(String name) {
    Color coo = Color.fromRGBO(18, 18, 18, 0.9);
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w500, color: coo),
            ),
            Icon(
              CupertinoIcons.chevron_down,
              color: coo,
            )
          ],
        ));
  }

  List<Widget> carouselPoints(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return currentIndex == index
          ? Container(
              margin: EdgeInsets.only(bottom: 40, right: 5),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border(
                  bottom: BorderSide(color: mainColor, width: 1),
                  top: BorderSide(color: mainColor, width: 1),
                  left: BorderSide(color: mainColor, width: 1),
                  right: BorderSide(color: mainColor, width: 1),
                ),
              ),
              child: Center(
                  child: Container(
                width: 6,
                height: 6,
                decoration:
                    BoxDecoration(color: mainColor, shape: BoxShape.circle),
              )),
            )
          : Container(
              margin: EdgeInsets.only(bottom: 40, right: 5),
              width: 6,
              height: 6,
              decoration:
                  BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
            );
    });
  }
}
