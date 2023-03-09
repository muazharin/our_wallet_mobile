import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/trans_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/utils/form_validation.dart';
import 'package:getx/views/widgets/button_loading.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/input_text_field.dart';
import 'package:getx/views/widgets/select_image.dart';
import 'package:getx/views/widgets/select_category.dart';
import 'package:getx/views/widgets/svg_file.dart';

class TransCreate extends StatefulWidget {
  const TransCreate({Key? key, required this.type}) : super(key: key);
  final String? type;
  @override
  State<TransCreate> createState() => _TransCreateState();
}

class _TransCreateState extends State<TransCreate> {
  final TransController transController = Get.put(TransController());
  int? walletId;
  selectCategory() {
    FocusScope.of(context).requestFocus(FocusNode());
    Get.bottomSheet(
      SelectCategory(
        walletId: Get.arguments['wallet_id'],
        type: widget.type,
        tempId: transController.categoryId.value,
        tempGroupList: transController.transCategory.value.text,
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    );
  }

  setInit() {
    var data = {
      "type": widget.type,
      "walletId": "$walletId",
    };
    transController.getCategory(data);
  }

  doSend() {
    FocusScope.of(context).requestFocus(FocusNode());
    transController.handleTransaction(
      {
        "trans_wallet_id": "$walletId",
        "trans_type": widget.type!,
        "trans_category_id": "${transController.categoryId}",
        "trans_detail": transController.transDetail.value.text,
        "trans_price": transController.transPrice.value.text.replaceAll(".", "")
      },
      transController.images,
    );
  }

  @override
  void initState() {
    walletId = Get.arguments['wallet_id'];
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: primaryWater,
                    ),
                  ),
                  Text(
                    widget.type == "Kredit" ? "Top Up" : "Belanja",
                    style: subtitleSemiBold,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Form(
                  key: transController.key.value,
                  child: ListView(
                    children: [
                      SvgFile(filename: "${widget.type!.toLowerCase()}.svg"),
                      const SizedBox(height: 8),
                      InputTextField(
                        hintText: widget.type == "Kredit"
                            ? "Sumber Dana"
                            : "Kategori",
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: primaryWater,
                        ),
                        validator: validationString,
                        controller: transController.transCategory.value,
                        onTap: () {
                          selectCategory();
                        },
                        onChanged: (v) {
                          setState(() {
                            selectCategory();
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      InputTextField(
                        hintText: "Nominal",
                        validator: validationString,
                        controller: transController.transPrice.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            name: "",
                            locale: "ID",
                            decimalDigits: 0,
                          ),
                        ],
                        onChanged: (v) {},
                      ),
                      const SizedBox(height: 8),
                      SelectImage(
                        files: (v) {
                          transController.images.addAll(v);
                        },
                      ),
                      const SizedBox(height: 8),
                      InputTextField(
                        hintText: "Keterangan",
                        minLines: 4,
                        maxLines: 4,
                        validator: validationString,
                        controller: transController.transDetail.value,
                        onChanged: (v) {},
                      ),
                    ],
                  ),
                ),
              ),
              transController.isLoading.value
                  ? const ButtonLoading()
                  : ButtonPrimary(
                      text: "Kirim",
                      textColor: Colors.white,
                      onTap: () {
                        doSend();
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
