import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/models/wallet_model.dart';
import 'package:getx/services/service_global.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/utils/constant.dart';

class WalletController extends GetxController {
  var wallet = WalletModel();
  var walletName = TextEditingController().obs;
  var walletMoney = TextEditingController().obs;
  var key = GlobalKey<FormState>().obs;
  var color = "red".obs;
  var index = 0.obs;
  var isLoading = false.obs;
  var isUpdate = false.obs;
  List<WalletModel> walletListCard = [
    WalletModel(
      walletId: 0,
      walletName: "Card 1",
      walletMoney: 0,
      walletColor: "red",
    ),
    WalletModel(
      walletId: 1,
      walletName: "Card 2",
      walletMoney: 0,
      walletColor: "black",
    ),
    WalletModel(
      walletId: 2,
      walletName: "Card 3",
      walletMoney: 0,
      walletColor: "blue",
    ),
    WalletModel(
      walletId: 3,
      walletName: "Card 4",
      walletMoney: 0,
      walletColor: "green",
    ),
    WalletModel(
      walletId: 4,
      walletName: "Card 5",
      walletMoney: 0,
      walletColor: "grey",
    ),
    WalletModel(
      walletId: 5,
      walletName: "Card 6",
      walletMoney: 0,
      walletColor: "purple",
    ),
    WalletModel(
      walletId: 6,
      walletName: "Card 7",
      walletMoney: 0,
      walletColor: "yellow",
    ),
  ];

  void snackbar(String value, bool status) {
    if (status) {
      Get.snackbar(
        "Berhasil",
        value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: variantCactus,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Kesalahan",
        value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: primaryBlood,
        colorText: Colors.white,
      );
    }
  }

  void onIndexChanged(int i) {
    index.value = i;
    color.value = walletListCard[index.value].walletColor!;
  }

  bool validation() {
    if (walletName.value.text == "" ||
        walletMoney.value.text == "" ||
        color.value == "") {
      return false;
    } else {
      return true;
    }
  }

  void handleAddWallet(Map data) async {
    if (key.value.currentState!.validate()) {
      key.value.currentState!.save();
      isLoading(true);
      GlobalServices()
          .post(createwallet, data, header: await BaseHeader.getHeaderToken())
          .then((value) {
        isLoading(false);
        if (value is String) {
          snackbar(value, false);
        } else {
          final response = jsonDecode(value.body);
          if (response['status']) {
            Get.offNamed("/main_menu", arguments: {"isNew": false});
          } else {
            snackbar(response["message"], false);
          }
        }
      });
    }
  }

  void handleUpdateWallet() {}
}
