import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:lottie/lottie.dart';

class CustomDialog {
  void succesOrFailedDialog({required bool? status, required String? message}) {
    Get.defaultDialog(
      title: status! ? "Berhasil!" : "Gagal!",
      titleStyle: subtitleSemiBold,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            status ? "assets/lottie/success.json" : "assets/lottie/failed.json",
            repeat: false,
          ),
          Text(
            status ? "Yess!!" : "Ups!!",
            style: contentRegular,
            textAlign: TextAlign.center,
          ),
          Text(
            message!,
            style: contentRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void yesOrNoDialog({
    required Function()? onTapYes,
    required Function()? onTapNo,
    required String? question,
    required String? type,
    String? title,
    String? yes,
    String? no,
  }) {
    Get.defaultDialog(
      title: title ?? "Perhatian!",
      titleStyle: subtitleSemiBold,
      middleText: question!,
      middleTextStyle: contentRegular,
      radius: 12,
      cancel: ButtonPrimary(
        text: yes ?? "Ya",
        textColor: Colors.white,
        // bgColor: type == "info" ? primaryWater : primaryBlood,
        bgColor: primaryWater,
        onTap: onTapYes,
      ),
      confirm: ButtonPrimary(
        text: no ?? "Gak jadi",
        textColor: primaryWater,
        bgColor: primaryWaterLight,
        onTap: onTapNo,
      ),
    );
  }
}
