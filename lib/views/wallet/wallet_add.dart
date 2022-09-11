import 'package:card_swiper/card_swiper.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/wallet_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/utils/form_validation.dart';
import 'package:getx/views/widgets/button_loading.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/button_text.dart';
import 'package:getx/views/widgets/input_text_field.dart';
import 'package:getx/views/widgets/wallet_card.dart';

class WalletAdd extends StatefulWidget {
  const WalletAdd({Key? key, required this.isUpdate}) : super(key: key);
  final bool? isUpdate;
  @override
  State<WalletAdd> createState() => _WalletAddState();
}

class _WalletAddState extends State<WalletAdd> {
  final WalletController walletController = Get.put(WalletController());
  final currencyFormatter = CurrencyTextInputFormatter(
    name: "",
    locale: "ID",
    decimalDigits: 0,
  );
  @override
  void initState() {
    setInit();
    super.initState();
  }

  setInit() {
    walletController.index.value = 0;
    if (widget.isUpdate!) {
      setWalletColor();
    }
  }

  setWalletColor() {
    walletController.wallet = Get.arguments['wallet'];
    walletController.walletName.value.text =
        walletController.wallet.walletName!;
    walletController.walletMoney.value.text =
        currencyFormatter.format("${walletController.wallet.walletMoney!}");
    walletController.color.value = walletController.wallet.walletColor!;
    for (var i = 0; i < walletController.walletListCard.length; i++) {
      if (walletController.walletListCard[i].walletColor ==
          walletController.color.value) {
        walletController.index.value =
            walletController.walletListCard[i].walletId!;
      }
    }
  }

  void createWallet() {
    FocusScope.of(context).requestFocus(FocusNode());
    walletController.handleAddWallet({
      "name": walletController.walletName.value.text,
      "money": walletController.walletMoney.value.text.replaceAll(".", ""),
      "color": walletController.color.value,
    });
  }

  void updateWallet() {
    FocusScope.of(context).requestFocus(FocusNode());
    walletController.handleUpdateWallet({
      "name": walletController.walletName.value.text,
      "money": walletController.walletMoney.value.text.replaceAll(".", ""),
      "color": walletController.color.value,
      "wallet_id": walletController.wallet.walletId.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: primaryBlood,
                      ),
                    ),
                    Text(
                      widget.isUpdate! ? "Update" : "Buat Baru",
                      style: subtitleSemiBold,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: walletController.key.value,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                "assets/svg/wallet.svg",
                                height: 150,
                                width: 150,
                              ),
                            ),
                            const SizedBox(height: 16),
                            InputTextField(
                              hintText: "Masukkan Nama Dompet",
                              controller: walletController.walletName.value,
                              validator: validationString,
                              onChanged: (v) => setState(() {}),
                            ),
                            const SizedBox(height: 16),
                            InputTextField(
                              hintText: "Masukkan Setoran Awal",
                              controller: walletController.walletMoney.value,
                              validator: validationString,
                              keyboardType: TextInputType.number,
                              enabled: !widget.isUpdate!,
                              inputFormatters: [
                                CurrencyTextInputFormatter(
                                  name: "",
                                  locale: "ID",
                                  decimalDigits: 0,
                                ),
                              ],
                              onChanged: (v) => setState(() {}),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: WalletCard(
                                isCreate: true,
                                walletModel:
                                    walletController.walletListCard[index],
                              ),
                            );
                          },
                          index: walletController.index.value,
                          onIndexChanged: (i) {
                            walletController.onIndexChanged(i);
                          },
                          physics: const ScrollPhysics(),
                          itemCount: walletController.walletListCard.length,
                          itemWidth: MediaQuery.of(context).size.width,
                          itemHeight: 200.0,
                          layout: SwiperLayout.STACK,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: walletController.isLoading.value
                    ? const ButtonLoading()
                    : ButtonPrimary(
                        text: "Simpan",
                        textSize: 16,
                        bgColor: walletController.validation()
                            ? primaryBlood
                            : primaryBloodLight,
                        hvColor: walletController.validation()
                            ? primaryBloodLight
                            : Colors.white,
                        onTap: walletController.validation()
                            ? () {
                                if (widget.isUpdate!) {
                                  updateWallet();
                                } else {
                                  createWallet();
                                }
                              }
                            : null,
                      ),
              ),
              widget.isUpdate!
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: ButtonText(
                        text: "Hapus Dompet",
                        textColor: primaryBlood,
                        textSize: 16,
                        onTap: () {
                          Get.defaultDialog(
                            title: "Hapus",
                            titleStyle: subtitleSemiBold,
                            middleText: "Data akan dihapus, lanjutkan?",
                            middleTextStyle: contentRegular,
                            radius: 12,
                            cancel: ButtonPrimary(
                              text: "Ya",
                              onTap: () {},
                            ),
                            confirm: ButtonPrimary(
                              text: "Batal",
                              textColor: primaryBlood,
                              bgColor: primaryBloodLight,
                              onTap: () => Get.back(),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
