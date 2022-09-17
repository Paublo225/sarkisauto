// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sarkisauto/assets/custom_icons.dart';
import 'package:sarkisauto/auth/auth.dart';
import 'package:sarkisauto/helpers/style.dart';
import 'package:sarkisauto/item/itemCard.dart';
import 'package:sarkisauto/models/partsAdvert.dart';
import 'package:sarkisauto/services/itemService.dart';

class HomePage extends StatefulWidget {
  String? accessCode;
  HomePage({Key? key, this.accessCode}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late TabController tabController;
  bool _loading = false;
  List<ItemCard> itemCardList = [];
  fetchAdverts() async {
    setState(() {
      _loading = true;
    });
    List<PartsAdvert> resp =
        await ItemServices.fetchParts(widget.accessCode!, 'PASSENGER');

    for (var el in resp) {
      itemCardList.add(ItemCard(itemModel: el));
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAdverts();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width - 110;
    double? itemHeightFactor;
    print(size);
    if (size.height > 680) {
      itemHeightFactor = 1.4;
    } else {
      itemHeightFactor = 1.0;
    }
    print(itemHeightFactor);
    const TextStyle tabbarTextStyle = TextStyle(
        fontSize: 14,
        color: tabTextColor,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark, // play with this

        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
                color: Colors.white, child: SafeArea(child: navBar(context))),
            body: SafeArea(
                child: Column(children: [
              Row(children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                  ),
                  width: itemWidth,
                  height: 40,
                  child: CupertinoSearchTextField(
                    prefixInsets: const EdgeInsets.only(left: 10),
                    suffixInsets: const EdgeInsets.only(right: 20),
                    prefixIcon: const Icon(Icons.search, size: 16),
                    controller: _textController,
                    //  prefixInsets: EdgeInsets.only(left: 8, right: 3),
                    placeholder: "Поиск",
                    suffixMode: OverlayVisibilityMode.always,
                    suffixIcon: const Icon(
                      CustomIcons.menu,
                      color: Colors.grey,
                      size: 12,
                    ),
                    placeholderStyle: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                        fontSize: 14),
                    style: const TextStyle(
                        color: Colors.black, fontFamily: "Circe", fontSize: 14),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 6,
                              offset: Offset(0, 1)),
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 2,
                              offset: Offset(0, 1)),
                        ]),
                    onChanged: (val) {},
                    onTap: () {},
                    onSuffixTap: () {},
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (builder) => AuthPage()));
                    },
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: Image.asset('lib/assets/Vector.png')))
              ]),
              TabBar(
                controller: tabController,
                indicatorColor: mainColor,
                isScrollable: true,
                indicatorPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                labelStyle: const TextStyle(color: Colors.black),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                        width: 2, color: Color.fromRGBO(71, 164, 242, 1))),
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  const Tab(
                      child: Text(
                    "Запчасти",
                    maxLines: 1,
                    style: tabbarTextStyle,
                  )),
                  const Tab(
                    child: Text(
                      "СТО",
                      maxLines: 1,
                      style: tabbarTextStyle,
                    ),
                  ),
                  const Tab(
                    child: Text(
                      "Шиномонтаж",
                      style: tabbarTextStyle,
                    ),
                  ),
                  const Tab(
                    child: Text(
                      "Автомойка",
                      maxLines: 1,
                      style: tabbarTextStyle,
                    ),
                  ),
                ],
                onTap: (index) {},
              ),
              categoryIcons(),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: const [
                      Text(
                        "Сортировать по",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: mainColor),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        CustomIcons.sort,
                        size: 11,
                        color: mainColor,
                      )
                    ],
                  ),
                )
              ]),
              _loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10,
                                childAspectRatio:
                                    MediaQuery.of(context).size.width /
                                        (size.height / itemHeightFactor),
                              ),
                              itemCount: itemCardList.length,
                              itemBuilder: (context, i) {
                                return itemCardList[i];
                              }))),
            ]))));
  }

  int pageIndex = 0;
  Widget navBar(BuildContext context) {
    const double iconSize = 25.00;
    const Color inActiveColor = Color.fromRGBO(18, 18, 18, 0.3);
    TextStyle textStyle(Color col) => TextStyle(
        fontSize: 10,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
        color: col);
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(32, 33, 32, 32),
              blurRadius: 20,
              offset: Offset(0, -20))
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(alignment: Alignment.topCenter,

              // fit: StackFit.passthrough,
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ? const Icon(
                          CustomIcons.home,
                          color: mainColor,
                          size: iconSize,
                        )
                      : const Icon(
                          CustomIcons.home,
                          color: inActiveColor,
                          size: iconSize,
                        ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: Text(
                      "Поиск",
                      style:
                          textStyle(pageIndex == 0 ? mainColor : inActiveColor),
                    )),
              ]),
          Stack(alignment: Alignment.topCenter, children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      CustomIcons.heart,
                      color: mainColor,
                      size: iconSize,
                    )
                  : const Icon(
                      CustomIcons.heart,
                      color: inActiveColor,
                      size: iconSize,
                    ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  "Избранное",
                  style: textStyle(pageIndex == 1 ? mainColor : inActiveColor),
                )),
          ]),
          Stack(alignment: Alignment.topCenter, children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      CustomIcons.add,
                      color: mainColor,
                      size: iconSize,
                    )
                  : const Icon(
                      CustomIcons.add,
                      color: inActiveColor,
                      size: iconSize,
                    ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  "Разместить",
                  style: textStyle(pageIndex == 2 ? mainColor : inActiveColor),
                )),
          ]),
          Stack(alignment: Alignment.topCenter, children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      CustomIcons.user,
                      color: mainColor,
                      size: iconSize,
                    )
                  : const Icon(
                      CustomIcons.user,
                      color: inActiveColor,
                      size: iconSize,
                    ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  "Аккаунт",
                  style: textStyle(pageIndex == 3 ? mainColor : inActiveColor),
                )),
          ])
        ],
      ),
    );
  }

  Widget categoryIcons() {
    return Container(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(alignment: AlignmentDirectional.center, children: [
            Text(
              "Запчасти",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.transparent,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
            GestureDetector(
                onTap: () async {}, child: Image.asset('lib/assets/parts.png')),
          ]),
          Stack(alignment: AlignmentDirectional.center, children: [
            Text(
              "СТО",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.transparent,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
            GestureDetector(
                onTap: () async {
                  await ItemServices.fetchParts(
                      widget.accessCode!, 'PASSENGER');
                },
                child: Image.asset('lib/assets/repair.png')),
          ]),
          Stack(alignment: AlignmentDirectional.center, children: [
            Text(
              "Шиномонтаж",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.transparent,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
            Image.asset('lib/assets/tires.png'),
          ]),
          Stack(alignment: AlignmentDirectional.center, children: [
            Text(
              "Автомойка",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.transparent,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
            Image.asset('lib/assets/carwash.png'),
          ]),
        ],
      ),
    );
  }
}
