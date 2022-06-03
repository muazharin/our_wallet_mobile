import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/services/service_global.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/utils/constant.dart';
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
        backgroundColor: primaryBlood,
        colorText: Colors.white,
      );
    }
  }

  void setGender(Object v) {
    gender.value = v;
  }

  void setDate(DateTime date) {
    tglLahir.value.text = '${date.year}-${date.month}-${date.day}';
  }

  void setLocalStorage(data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt("id", int.parse(data['id']));
    sp.setString("username", data['username']);
    sp.setString("email", data['email']);
    sp.setString("phone", data['phone']);
    sp.setString("photo", data['photo']);
    sp.setString("gender", data['gender']);
    sp.setString("tgllahir", data['tgllahir']);
    sp.setString("address", data['address']);
  }

  void checkLogin() async {
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      if (sp.getInt('id') != null) {
        Get.offNamed("/main_menu");
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
            snackbar(response["message"], false);
          } else {
            Get.toNamed("/auth_register_form");
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
            Get.offNamed("/main_menu");
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

  void authCreatePassword(Map data, String? phone, bool isRecreate) async {
    if (cpassKey.value.currentState!.validate()) {
      cpassKey.value.currentState!.save();
      isLoading(true);
      GlobalServices()
          .post("${authcreatepassword!}?phone=${phone!}", data)
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
              Get.offAllNamed("/main_menu");
            }
          } else {
            snackbar(response["message"], false);
          }
        }
      });
    }
  }
}
