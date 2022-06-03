import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/profile_controller.dart';
import 'package:getx/themes/fonts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController profileController = Get.put(ProfileController());
  String title = "Profile";
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
