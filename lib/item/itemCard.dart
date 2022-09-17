// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sarkisauto/assets/custom_icons.dart';
import 'package:sarkisauto/helpers/style.dart';
import 'package:sarkisauto/item/itemScreen.dart';
import 'package:sarkisauto/models/itemModel.dart';
import 'package:sarkisauto/models/partsAdvert.dart';

class ItemCard extends StatefulWidget {
  PartsAdvert itemModel;

  ItemCard({required this.itemModel});
  _ItemCardState createState() => new _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  String? price;
  DateTime? dateCreated;
  String dateTime = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateCreated = DateTime.parse(widget.itemModel.dateCreate);
    price = widget.itemModel.price.toString();
    dateTime =
        "${dateCreated!.day} сентября ${dateCreated!.year}, ${dateCreated!.hour}:${dateCreated!.minute}";
    if (price!.length > 2) {
      price = price!.substring(0, 2) + " " + price!.substring(2, price!.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (builder) => ItemScreen(
                            itemModel: widget.itemModel,
                            dateCreate: dateTime,
                          )))
            },
        child: Container(
          height: 275,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                spreadRadius: 0.8,
                blurRadius: 6,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              height: 170,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Stack(fit: StackFit.expand, children: [
                        Image(
                            fit: BoxFit.fill,
                            width: double.infinity,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (contex, object, tyy) => Image.asset(
                                  "lib/assets/gn_loading.png",
                                  fit: BoxFit.contain,
                                ),
                            image: NetworkImage(
                              widget.itemModel.photo,
                            )),
                        Container(
                            padding: EdgeInsets.only(right: 9, top: 6),
                            alignment: Alignment.topRight,
                            child: const Icon(
                              CupertinoIcons.heart,
                              size: 16,
                              color: Colors.white,
                            )),
                      ]))),
            ),
            Flexible(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 6, left: 8, right: 8),
                  child: Text(widget.itemModel.nameOfPart,
                      style: TextStyle(fontSize: 12)
                      // overflow: TextOverflow.ellipsis,
                      ),
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 6, left: 8, right: 8),
              child: Text(
                "$price ₽",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 3, left: 8, right: 8),
              child: RatingBar.builder(
                initialRating: 3,
                itemSize: 8,

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
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Text(
                widget.itemModel.address,
                softWrap: false,
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 10, color: Colors.grey),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Text(
                dateTime,
                style: TextStyle(fontSize: 10, color: Colors.grey),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
        ));
  }
}
