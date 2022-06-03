import 'package:flutter/material.dart';
import 'package:getx/themes/fonts.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String title = "History";
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
