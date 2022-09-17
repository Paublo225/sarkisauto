import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sarkisauto/helpers/style.dart';
import 'package:sarkisauto/homePage/homePage.dart';
/*
class DefaultTabBar extends StatefulWidget {
  int? indexTab;
  int? mainIndex;
  bool? cartFlag;
  DefaultTabBar({Key? key, this.indexTab, this.mainIndex, this.cartFlag})
      : super(key: key);
  @override
  DefaultTabBarState createState() => new DefaultTabBarState();
}

class DefaultTabBarState extends State<DefaultTabBar>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _tabIndex = 0;
  CupertinoTabController _tabController =
      new CupertinoTabController(initialIndex: 0);

  void initState() {
    super.initState();
    _tabController = CupertinoTabController(initialIndex: 0);

    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double media = 25;
    var height = 50;

    return CupertinoTabScaffold(
      controller: _tabController,
      tabBar: CupertinoTabBar(
        activeColor: mainColor,
        backgroundColor: Colors.white,
        inactiveColor: Colors.black,
        // indicatorWeight: 40,
        //indicatorPadding: EdgeInsets.only(top: 40, left: 50),
        items: <BottomNavigationBarItem>[
          /*  Tab(
                      iconMargin: EdgeInsets.only(top: 5.0),
                      icon: Icon(GNeeds.spray_paint, size: 35),
                      text: ""),*/
          BottomNavigationBarItem(
            label: "Главная",
            // iconMargin: EdgeInsets.only(top: 5.0),
            icon: Icon(CupertinoIcons.settings, size: media),
          ),
          BottomNavigationBarItem(
            label: "Категории",
            // iconMargin: EdgeInsets.only(top: 5.0),
            icon: Icon(CupertinoIcons.heart, size: media),
          ),
          BottomNavigationBarItem(
            label: "Корзина",
            icon: Icon(
              CupertinoIcons.add_circled_solid,
              size: media,
              //   color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: "Профиль",
            icon: Icon(CupertinoIcons.person, size: media),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomePage(),
              );
            });

          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomePage(),
              );
            });

          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomePage(),
              );
            });

          case 3:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomePage(),
              );
            });

          default:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomePage(),
              );
            });
        }
      },
    );
  }
}
*/