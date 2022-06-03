import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/auth_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/utils/form_validation.dart';
import 'package:getx/views/widgets/button_loading.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/input_text_field.dart';
import 'package:getx/views/widgets/svg_file.dart';

class AuthRegisterForm extends StatefulWidget {
  const AuthRegisterForm({Key? key}) : super(key: key);

  @override
  State<AuthRegisterForm> createState() => _AuthRegisterFormState();
}

class _AuthRegisterFormState extends State<AuthRegisterForm> {
  final AuthController authController = Get.put(AuthController());
  String filename = "form.svg";

  @override
  void initState() {
    authController.gender.value = "Pria";
    super.initState();
  }

  void daftar() {
    FocusScope.of(context).requestFocus(FocusNode());
    authController.authRegister({
      'username': authController.username.value.text,
      'email': authController.email.value.text,
      'phone': authController.phoneNumber.value.text,
      'gender': authController.gender.toString(),
      'tgllahir': authController.tglLahir.value.text,
      'address': authController.address.value.text,
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
                "Form Pendaftaran",
                style: titleSemiBold,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(() {
                    return Form(
                      key: authController.formKey.value,
                      child: Column(
                        children: [
                          Center(child: SvgFile(filename: filename)),
                          const SizedBox(height: 16),
                          InputTextField(
                            hintText: "Masukkan Username",
                            validator: validationString,
                            controller: authController.username.value,
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            hintText: "Masukkan Email",
                            validator: validationEmail,
                            keyboardType: TextInputType.emailAddress,
                            controller: authController.email.value,
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            hintText: "Masukkan Nomor Telepon",
                            validator: validationPhoneNumber,
                            keyboardType: TextInputType.phone,
                            controller: authController.phoneNumber.value,
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Radio(
                                value: "Pria",
                                groupValue: authController.gender.value,
                                onChanged: (v) {
                                  setState(() {
                                    authController.setGender(v!);
                                  });
                                },
                              ),
                              Text(
                                "Pria",
                                style: contentRegular.copyWith(
                                  color: grayscaleCharcoalLightest,
                                ),
                              ),
                              const Spacer(),
                              Radio(
                                value: "Wanita",
                                groupValue: authController.gender.value,
                                onChanged: (v) {
                                  setState(() {
                                    authController.setGender(v!);
                                  });
                                },
                              ),
                              Text(
                                "Wanita",
                                style: contentRegular.copyWith(
                                  color: grayscaleCharcoalLightest,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            hintText: "Pilih Tanggal Lahir",
                            validator: validationString,
                            keyboardType: TextInputType.phone,
                            controller: authController.tglLahir.value,
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DatePicker.showDatePicker(
                                context,
                                theme: const DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime.now(),
                                onConfirm: (date) {
                                  setState(() {
                                    authController.setDate(date);
                                  });
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.id,
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          InputTextField(
                            hintText: "Masukkan Alamat",
                            validator: validationString,
                            controller: authController.address.value,
                            maxLines: 4,
                          ),
                          const SizedBox(height: 16),
                          authController.isLoading.value
                              ? const ButtonLoading()
                              : ButtonPrimary(
                                  text: "Daftar",
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    daftar();
                                  },
                                ),
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
