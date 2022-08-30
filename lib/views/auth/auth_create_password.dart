import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/auth_controller.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/utils/form_validation.dart';
import 'package:getx/views/widgets/button_loading.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/input_text_field.dart';
import 'package:getx/views/widgets/svg_file.dart';

class AuthCreatePassword extends StatefulWidget {
  const AuthCreatePassword({Key? key}) : super(key: key);

  @override
  State<AuthCreatePassword> createState() => _AuthCreatePasswordState();
}

class _AuthCreatePasswordState extends State<AuthCreatePassword> {
  final AuthController authController = Get.put(AuthController());
  String filename = "create.svg";
  bool isRecreate = false;
  @override
  void initState() {
    setState(() {
      isRecreate = Get.arguments['isRecreate'];
    });
    super.initState();
  }

  void simpan() {
    FocusScope.of(context).requestFocus(FocusNode());
    authController.authCreatePassword(
      {'password': authController.password.value.text},
      Get.arguments['data'],
      isRecreate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: authController.cpassKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isRecreate ? "Ubah Password" : "Buat Password",
                  style: titleSemiBold,
                ),
                const SizedBox(height: 16),
                Center(child: SvgFile(filename: filename)),
                const SizedBox(height: 16),
                InputTextField(
                  hintText: "Masukkan Password",
                  validator: validationPassword,
                  controller: authController.password.value,
                  isPassword: true,
                ),
                const SizedBox(height: 8),
                InputTextField(
                  hintText: "Masukkan Konfirmasi Password",
                  validator: (value) {
                    String pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    RegExp regExp = RegExp(pattern);
                    if (value!.isEmpty) {
                      return "Password harus diisi";
                    } else if (value != authController.password.value.text) {
                      return "Password tidak sama";
                    } else if (!regExp.hasMatch(value)) {
                      return "Minimal password 9 karakter dan harus memiliki minimal 1 huruf kecil, 1 huruf besar,1 angka dan 1 spesial character ( ! @ # \$ & * ~ ) ";
                    }
                    return null;
                  },
                  controller: authController.passwordConfirm.value,
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                authController.isLoading.value
                    ? const ButtonLoading()
                    : ButtonPrimary(
                        text: "Simpan",
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          simpan();
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
