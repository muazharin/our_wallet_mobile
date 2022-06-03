import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/auth_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/img_file.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.put(AuthController());
  String title = "Our Wallet";

  @override
  void initState() {
    authController.checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ImgFile(filename: "wallet_red.png"),
              const SizedBox(height: 8),
              Text(
                title,
                style: titleSemiBold.copyWith(
                  color: primaryBlood,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
