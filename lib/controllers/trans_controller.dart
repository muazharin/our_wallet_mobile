import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/home_controller.dart';
import 'package:getx/models/category_model.dart';
import 'package:getx/services/service_global.dart';
import 'package:getx/utils/constant.dart';
import 'package:getx/utils/custom_dialog.dart';

class TransController extends GetxController {
  ResultCategoryModel resultCategoryModel = ResultCategoryModel();
  List<CategoryModel> listCategory = [];
  var transCategory = TextEditingController().obs;
  var transPilihan = TextEditingController().obs;
  var transDetail = TextEditingController().obs;
  var transPrice = TextEditingController().obs;
  var images = <File>[];
  var categoryId = 0.obs;
  var isLoading = false.obs;
  var isLoadingCategory = false.obs;
  var isLoadingAdd = false.obs;
  var isErrorCategory = false.obs;
  var errorCategory = "".obs;
  var groupList = "".obs;
  var page = 1.obs;
  var key = GlobalKey<FormState>().obs;
  var keyAdd = GlobalKey<FormState>().obs;

  void getCategory(Map data) async {
    isLoadingCategory(true);
    GlobalServices()
        .get(
      '$getcategory?page=$page&type=${data["type"]}&walletId=${data["walletId"]}',
      header: await BaseHeader.getHeaderToken(),
    )
        .then((value) {
      isLoadingCategory(false);
      if (value is String) {
        isErrorCategory(true);
        errorCategory(value);
      } else {
        final response = jsonDecode(value.body);
        if (response['status']) {
          resultCategoryModel = ResultCategoryModel.fromJson(response);
          listCategory = resultCategoryModel.data!;
        } else {
          isErrorCategory(true);
          errorCategory(response['message']);
        }
      }
    });
  }

  void handleTransaction(Map<String, String> data, List<File> file) async {
    if (key.value.currentState!.validate()) {
      key.value.currentState!.save();
      isLoading(true);
      GlobalServices()
          .postWithFile(createtransaction, data, file)
          .then((value) {
        Get.offNamed(
          "/main_menu",
          arguments: {"isNew": false, "isReload": true},
        );
        isLoading(false);
        Future.delayed(const Duration(milliseconds: 500), () {
          CustomDialog().succesOrFailedDialog(
            status: value['status'],
            message: value['message'],
          );
        });
      });
    }
  }

  void handleAddCategory(Map data) async {
    if (keyAdd.value.currentState!.validate()) {
      keyAdd.value.currentState!.save();
      isLoadingAdd(true);
      GlobalServices()
          .post(createcategory, data, header: await BaseHeader.getHeaderToken())
          .then((value) {
        isLoadingAdd(false);

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
  }

  void handleUpdateCategory(Map data) async {
    if (keyAdd.value.currentState!.validate()) {
      keyAdd.value.currentState!.save();
      isLoadingAdd(true);
      GlobalServices()
          .put(updatecategory, data, header: await BaseHeader.getHeaderToken())
          .then((value) {
        isLoadingAdd(false);

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
  }

  void handleDeleteCategory(Map data) async {
    if (keyAdd.value.currentState!.validate()) {
      keyAdd.value.currentState!.save();
      isLoadingAdd(true);
      GlobalServices()
          .put("$deletecategory?category_id=${data['category_id']}", {},
              header: await BaseHeader.getHeaderToken())
          .then((value) {
        isLoadingAdd(false);
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
  }
}
