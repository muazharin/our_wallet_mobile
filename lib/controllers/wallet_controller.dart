import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/models/wallet_model.dart';
import 'package:getx/services/service_global.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/utils/constant.dart';
import 'package:getx/utils/custom_dialog.dart';

class WalletController extends GetxController {
  ResultWalletModel resultWalletModel = ResultWalletModel();
  ResultWalletForMemberModel resultWalletForMemberModel =
      ResultWalletForMemberModel();
  List<WalletModel> list = [];
  List<WalletForMemberModel> listForMember = [];
  List<WalletForMemberModel> listForMemberAdd = [];
  var wallet = WalletModel();
  var walletName = TextEditingController().obs;
  var walletMoney = TextEditingController().obs;
  var walletKeyword = TextEditingController().obs;
  var key = GlobalKey<FormState>().obs;
  var color = "red".obs;
  var page = 1.obs;
  var index = 0.obs;
  var isLoading = false.obs;
  var isLoadingList = false.obs;
  var isLoadingAddMember = false.obs;
  var isLoadingSearch = false.obs;
  var isErrorList = false.obs;
  var isErrorSearch = false.obs;
  var errorList = "".obs;
  var errorSearch = "".obs;
  var isSearch = false.obs;
  Timer? debounce;

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
        backgroundColor: primaryWater,
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

  void onSearchChanged({walletId}) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(seconds: 1), () {
      isErrorSearch(false);
      getMemberForWallet({
        "wallet_id": walletId,
        "keyword": walletKeyword.value.text,
      });
    });
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
            Get.offNamed(
              "/main_menu",
              arguments: {"isNew": false, "isReload": true},
            );
          } else {
            snackbar(response["message"], false);
          }
        }
      });
    }
  }

  void handleAddMemberWallet(Map data) async {
    isLoadingAddMember(true);
    GlobalServices()
        .post(addmemberwallet, data, header: await BaseHeader.getHeaderToken())
        .then((value) {
      isLoadingAddMember(false);
      Get.back();
      if (value is String) {
        CustomDialog().succesOrFailedDialog(
          status: false,
          message: value,
        );
      } else {
        final response = jsonDecode(value.body);
        CustomDialog().succesOrFailedDialog(
          status: response['status'],
          message: response['message'],
        );
      }
    });
  }

  void handleUpdateWallet(Map data) async {
    if (key.value.currentState!.validate()) {
      key.value.currentState!.save();
      isLoading(true);
      GlobalServices()
          .put(updatewallet, data, header: await BaseHeader.getHeaderToken())
          .then((value) {
        isLoading(false);
        if (value is String) {
          snackbar(value, false);
        } else {
          final response = jsonDecode(value.body);
          if (response['status']) {
            Get.offNamed(
              "/main_menu",
              arguments: {"isNew": false, "isReload": true},
            );
          } else {
            snackbar(response["message"], false);
          }
        }
      });
    }
  }

  void getMemberForWallet(Map data) async {
    isLoadingSearch(true);
    GlobalServices()
        .get(
            '${getmemberforwallet!}?wallet_id=${data["wallet_id"]}&keyword=${data["keyword"]}&page=$page',
            header: await BaseHeader.getHeaderToken())
        .then((value) {
      isLoadingSearch(false);
      if (value is String) {
        isErrorSearch(true);
        errorSearch(value);
      } else {
        final response = jsonDecode(value.body);
        if (response['status']) {
          resultWalletForMemberModel =
              ResultWalletForMemberModel.fromJson(response);
          listForMember = resultWalletForMemberModel.data!;
        } else {
          isErrorSearch(true);
          errorSearch(response['message']);
        }
      }
    });
  }

  void getOurWallet() async {
    isLoading(true);
    isErrorList(false);
    GlobalServices()
        .get2("$getourwallet?page=$page",
            header: await BaseHeader.getHeaderToken())
        .then((value) {
      isLoading(false);
      final response = jsonDecode(value.body);
      if (response['status']) {
        resultWalletModel = ResultWalletModel.fromJson(response);
        list = resultWalletModel.data!;
      } else {
        isErrorList(true);
      }
    }).catchError((err) {
      isLoading(false);
      isErrorList(true);
      errorList(err);
    });
  }
}
