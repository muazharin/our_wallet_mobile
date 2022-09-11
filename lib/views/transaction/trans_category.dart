import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/trans_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/utils/form_validation.dart';
import 'package:getx/views/widgets/button_loading.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/input_text_field.dart';
import 'package:getx/views/widgets/svg_file.dart';

class TransCategory extends StatefulWidget {
  const TransCategory({Key? key, required this.type}) : super(key: key);
  final String? type;
  @override
  State<TransCategory> createState() => _TransCategoryState();
}

class _TransCategoryState extends State<TransCategory> {
  final TransController transController = Get.put(TransController());
  List<String> list = [];
  bool? isResult = false;
  int? walletId = 0;

  List<String> debit = [
    'Makanan',
    'Minuman',
    'Pakaian',
    'Jajan',
    'Tagihan',
    'BBM',
    'Skincare',
    'Foya-foya',
    'Lifestyle',
    'Lainnya',
  ];
  List<String> kredit = [
    'Gaji',
    'Project',
    'Saham',
    'Bisnis',
    'Dana tak terduga',
    'Pasangan',
    'Orang tua',
    'Rejeki Anak Sholeh(ah)',
    'Lainnya',
  ];
  doSave() {
    FocusScope.of(context).requestFocus(FocusNode());
    transController.handleAddCategory({
      "category_title": transController.transPilihan.value.text,
      "category_type": widget.type,
      "category_wallet_id": "$walletId",
    });
    setState(() {
      isResult = true;
      transController.transPilihan.value.text = "";
    });
  }

  @override
  void initState() {
    walletId = Get.arguments['wallet_id'];
    if (widget.type == "Kredit") {
      setState(() => list = kredit);
    } else {
      setState(() => list = debit);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(result: isResult),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: primaryBlood,
                    ),
                  ),
                  Text(
                    widget.type == "Kredit"
                        ? "Tambah Sumber Dana"
                        : "Tambah Kategori",
                    style: subtitleSemiBold,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    const SvgFile(filename: "add_category.svg"),
                    const SizedBox(height: 16),
                    Form(
                      key: transController.keyAdd.value,
                      child: InputTextField(
                        hintText: "Masukkkan pilihan disini",
                        controller: transController.transPilihan.value,
                        validator: validationString,
                        onChanged: (v) {
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Rekomendasi:",
                      style: contentRegular,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      children: list.asMap().entries.map<Widget>((e) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                transController.transPilihan.value.text =
                                    e.value;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: transController
                                                .transPilihan.value.text
                                                .toLowerCase() ==
                                            e.value.toLowerCase()
                                        ? primaryBlood
                                        : grayscaleStone),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  e.value,
                                  style: contentRegular.copyWith(
                                    color: transController
                                                .transPilihan.value.text
                                                .toLowerCase() ==
                                            e.value.toLowerCase()
                                        ? primaryBlood
                                        : grayscaleCharcoal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              transController.isLoadingAdd.value
                  ? const ButtonLoading()
                  : ButtonPrimary(
                      text: "Simpan",
                      textColor: Colors.white,
                      onTap: () {
                        doSave();
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
