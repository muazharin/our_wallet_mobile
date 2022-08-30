import 'package:card_swiper/card_swiper.dart';
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
  const WalletAdd({Key? key}) : super(key: key);

  @override
  State<WalletAdd> createState() => _WalletAddState();
}

class _WalletAddState extends State<WalletAdd> {
  final WalletController walletController = Get.put(WalletController());
  @override
  void initState() {
    setInit();
    super.initState();
  }

  setInit() {
    walletController.index.value = 0;
  }

  void createWallet() {
    FocusScope.of(context).requestFocus(FocusNode());
    walletController.handleAddWallet({
      "name": walletController.walletName.value.text,
      "money": walletController.walletMoney.value.text,
      "color": walletController.color.value,
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  walletController.isUpdate.value
                      ? "Update Dompet"
                      : "Buat Dompet",
                  style: subtitleSemiBold,
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
                              validator: validationNumber,
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
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (walletController.isUpdate.value) {
                                  walletController.handleUpdateWallet();
                                } else {
                                  createWallet();
                                }
                              }
                            : null,
                      ),
              ),
              walletController.isUpdate.value
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: ButtonText(
                        text: "Hapus Dompet",
                        textColor: primaryBlood,
                        onTap: () {},
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
