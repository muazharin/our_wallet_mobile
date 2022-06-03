import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var walletName = TextEditingController().obs;
  var key = GlobalKey<FormState>().obs;
  var color = Object().obs;
  var isLoading = false.obs;
  var isUpdate = false.obs;

  void setColor(Object v) {
    color.value = v;
  }

  bool validation() {
    if (walletName.value.text == "" || color.value == "") {
      return false;
    } else {
      return true;
    }
  }

  void handleAddWallet() {
    if (key.value.currentState!.validate()) {
      key.value.currentState!.save();
      isLoading(true);
    }
  }

  void handleUpdateWallet() {}
}
