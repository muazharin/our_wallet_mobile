import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/services/service_global.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/utils/constant.dart';
import 'package:getx/utils/jwt_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var phoneNumber = TextEditingController().obs;
  var password = TextEditingController().obs;
  var passwordConfirm = TextEditingController().obs;
  var username = TextEditingController().obs;
  var email = TextEditingController().obs;
  var tglLahir = TextEditingController().obs;
  var address = TextEditingController().obs;
  var gender = Object().obs;
  var isLoading = false.obs;
  var checkKey = GlobalKey<FormState>().obs;
  var formKey = GlobalKey<FormState>().obs;
  var loginKey = GlobalKey<FormState>().obs;
  var cpassKey = GlobalKey<FormState>().obs;

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

  void setGender(Object v) {
    gender.value = v;
  }

  void setDate(DateTime date) {
    String day = "${date.day}";
    String month = "${date.month}";
    if (date.month < 10) {
      month = "0${date.month}";
    }
    if (date.day < 10) {
      day = "0${date.day}";
    }
    tglLahir.value.text = '${date.year}-$month-$day';
  }

  void setLocalStorage(token, {bool isStatus = false}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var data = parseJwt(token['token']);
    sp.setString("username", data['user_name']);
    sp.setString("email", data['user_email']);
    sp.setString("phone", data['user_phone']);
    sp.setString("photo", data['user_photo']);
    sp.setString("gender", data['user_gender']);
    sp.setString("tgllahir", data['user_tgl_lahir']);
    sp.setString("address", data['user_address']);
    sp.setString("created_at", data['user_created_at']);
    sp.setString("updated_at", data['user_updated_at']);
    sp.setString("user_status", isStatus ? "complete" : token['user_status']);
    sp.setString("token", token['token']);
  }

  void checkLogin() async {
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      if (sp.getString('token') != null &&
          sp.getString("user_status") == "complete") {
        Get.offNamed(
          "/main_menu",
          arguments: {"isNew": false, "isReload": true},
        );
      } else {
        Get.offNamed("/auth_login");
      }
    });
  }

  void authCheckPhoneNumber(Map data) async {
    if (checkKey.value.currentState!.validate()) {
      checkKey.value.currentState!.reset();
      isLoading(true);
      GlobalServices().post(authcheckphonenumber, data).then((value) {
        isLoading(false);
        if (value is String) {
          snackbar(value, false);
        } else {
          final response = jsonDecode(value.body);
          if (response['status']) {
            Get.toNamed("/auth_register_form");
          } else {
            if (response['data']['user_status'] == "incomplete") {
              Get.toNamed(
                "/auth_create_password",
                arguments: {
                  'isRecreate': false,
                  'data': response['data'],
                },
              );
            } else {
              snackbar(response["message"], false);
            }
          }
        }
      });
    }
  }

  void authLogin(Map data) async {
    if (loginKey.value.currentState!.validate()) {
      loginKey.value.currentState!.save();
      isLoading(true);
      GlobalServices().post(authlogin, data).then((value) {
        isLoading(false);
        if (value is String) {
          snackbar(value, false);
        } else {
          final response = jsonDecode(value.body);
          if (response['status']) {
            setLocalStorage(response['data']);
            Get.offNamed(
              "/main_menu",
              arguments: {"isNew": false, "isReload": false},
            );
          } else {
            snackbar(response["message"], false);
          }
        }
      });
    }
  }

  void authRegister(Map data) async {
    if (formKey.value.currentState!.validate()) {
      formKey.value.currentState!.save();
      isLoading(true);
      GlobalServices().post(authregister, data).then((value) {
        isLoading(false);
        if (value is String) {
          snackbar(value, false);
        } else {
          final response = jsonDecode(value.body);
          if (response['status']) {
            Get.offNamed(
              "/auth_create_password",
              arguments: {
                'isRecreate': false,
                'data': response['data'],
              },
            );
          } else {
            snackbar(response["message"], false);
          }
        }
      });
    }
  }

  void authCreatePassword(Map data, token, bool isRecreate) async {
    if (cpassKey.value.currentState!.validate()) {
      cpassKey.value.currentState!.save();
      isLoading(true);
      GlobalServices()
          .put(
        authcreatepassword!,
        data,
        header: await BaseHeader.getHeaderToken(data: token['token']),
      )
          .then((value) {
        isLoading(false);
        if (value is String) {
          snackbar(value, false);
        } else {
          final response = jsonDecode(value.body);
          if (response['status']) {
            if (isRecreate) {
              Get.offAllNamed("/auth_login");
            } else {
              setLocalStorage(token, isStatus: true);
              Get.offNamed(
                "/main_menu",
                arguments: {"isNew": true, "isReload": false},
              );
            }
          } else {
            snackbar(response["message"], false);
          }
        }
      });
    }
  }
}
