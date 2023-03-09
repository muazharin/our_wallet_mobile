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

class AuthRegister extends StatefulWidget {
  const AuthRegister({Key? key}) : super(key: key);

  @override
  State<AuthRegister> createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
  final AuthController authController = Get.put(AuthController());

  void daftar() {
    FocusScope.of(context).requestFocus(FocusNode());
    authController.authCheckPhoneNumber({
      'phone': authController.phoneNumber.value.text,
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
              Text(
                "Daftar",
                style: titleSemiBold,
              ),
              Expanded(
                child: Obx(() {
                  return Form(
                    key: authController.checkKey.value,
                    child: Column(
                      children: [
                        const SvgFile(filename: "register.svg"),
                        const SizedBox(height: 16),
                        InputTextField(
                          hintText: "Masukkan Nomor Telepon",
                          keyboardType: TextInputType.phone,
                          controller: authController.phoneNumber.value,
                          validator: validationPhoneNumber,
                        ),
                        const SizedBox(height: 16),
                        authController.isLoading.value
                            ? const ButtonLoading()
                            : ButtonPrimary(
                                text: "Daftar",
                                onTap: () {
                                  daftar();
                                },
                              ),
                      ],
                    ),
                  );
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Jika sudah memiliki akun? ",
                    style: smallRegular,
                  ),
                  ButtonText(
                    text: "Masuk",
                    textColor: primaryWater,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Get.back();
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
