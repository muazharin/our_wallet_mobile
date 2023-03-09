import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/views/menu/card_menu.dart';
import 'package:getx/views/menu/history_menu.dart';
import 'package:getx/views/menu/home_menu.dart';
import 'package:getx/views/menu/profile_menu.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int page = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: grayscaleStoneLight,
        child: page == 0
            ? const Home()
            : page == 1
                ? const Cards()
                : page == 2
                    ? const History()
                    : const Profile(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        color: primaryWater,
        backgroundColor: Colors.white,
        buttonBackgroundColor: primaryWater,
        animationDuration: const Duration(milliseconds: 200),
        height: 56,
        items: [
          Icon(
            Icons.home,
            size: 24,
            color: page == 0 ? Colors.white : grayscaleStoneLight,
          ),
          Icon(
            Icons.list,
            size: 24,
            color: page == 1 ? Colors.white : grayscaleStoneLight,
          ),
          Icon(
            Icons.history,
            size: 24,
            color: page == 2 ? Colors.white : grayscaleStoneLight,
          ),
          Icon(
            Icons.person,
            size: 24,
            color: page == 3 ? Colors.white : grayscaleStoneLight,
          ),
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
    );
  }
}
