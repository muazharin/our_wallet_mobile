import 'package:flutter/material.dart';
import 'package:getx/themes/fonts.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  String title = "Cards";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            title,
            style: contentRegular,
          ),
        ),
      ),
    );
  }
}
