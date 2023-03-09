import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/auth_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/utils/form_validation.dart';
import 'package:getx/views/widgets/button_loading.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/button_text.dart';
import 'package:getx/views/widgets/input_text_field.dart';
import 'package:getx/views/widgets/svg_file.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({Key? key}) : super(key: key);

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  final AuthController authController = Get.put(AuthController());
  String filename = "login.svg";

  void login() {
    FocusScope.of(context).requestFocus(FocusNode());
    authController.authLogin({
      'username': authController.username.value.text,
      'password': authController.password.value.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Masuk", style: titleSemiBold),
              Expanded(
                flex: 8,
                child: Center(
                  child: SingleChildScrollView(
                    child: Obx(() {
                      return Form(
                        key: authController.loginKey.value,
                        child: Column(
                          children: [
                            SvgFile(filename: filename),
                            const SizedBox(height: 16),
                            InputTextField(
                              hintText:
                                  "Masukkan Username, Email, atau Nomor Telepon",
                              controller: authController.username.value,
                              validator: validationString,
                            ),
                            const SizedBox(height: 8),
                            InputTextField(
                              hintText: "Masukkan Password",
                              isPassword: true,
                              validator: validationPassword,
                              controller: authController.password.value,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Spacer(),
                                ButtonText(
                                  text: "Lupa Password",
                                  textColor: grayscaleCharcoalLightest,
                                  onTap: () {
                                    // Get.toNamed("/auth_forgot_password");
                                    Get.toNamed("/cv");
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            authController.isLoading.value
                                ? const ButtonLoading()
                                : ButtonPrimary(
                                    text: "Masuk",
                                    onTap: () {
                                      login();
                                    },
                                  ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum memiliki akun? ",
                    style: smallRegular,
                  ),
                  ButtonText(
                    text: "Daftar",
                    textColor: primaryWater,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Get.toNamed("/auth_register");
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
