import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/splash_screen",
      defaultTransition: Transition.rightToLeft,
      getPages: getPages,
    );
  }
}
