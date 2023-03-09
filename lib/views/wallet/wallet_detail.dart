import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/home_controller.dart';
import 'package:getx/controllers/wallet_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/button_text.dart';
import 'package:getx/views/widgets/member_card.dart';
import 'package:getx/views/widgets/shimmer_loading.dart';
import 'package:intl/intl.dart';

class WalletDetail extends StatefulWidget {
  const WalletDetail({Key? key}) : super(key: key);

  @override
  State<WalletDetail> createState() => _WalletDetailState();
}

class _WalletDetailState extends State<WalletDetail> {
  final WalletController walletController = Get.put(WalletController());
  final HomeController homeController = Get.put(HomeController());
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {
          homeController.getMemberWallet({
            'wallet_id': walletController.wallet.walletId,
          });
        }));
    walletController.wallet = Get.arguments['wallet'];
  }

  setDateFormat(DateTime? date) {
    return DateFormat("dd MMM yy h:m:s").format(date!);
  }

  @override
  Widget build(BuildContext context) {
    // Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        "Detail",
                        style: subtitleSemiBold,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(
                        "/wallet_update",
                        arguments: {"wallet": walletController.wallet},
                      );
                    },
                    child: const Icon(
                      Icons.edit_outlined,
                      color: primaryWater,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          child: SizedBox(
                            height: 100,
                            width: 60,
                            child: Image.asset(
                              "assets/png/cards_${walletController.wallet.walletColor}.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  walletController.wallet.walletName!,
                                  style: contentRegular.copyWith(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Saldo",
                                      style: smallRegular,
                                    ),
                                    Text(
                                      'Rp ${currencyFormatter.format("${walletController.wallet.walletMoney!}")}',
                                      style: smallRegular.copyWith(
                                        color: variantCactus,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Bergabung",
                                      style: smallRegular,
                                    ),
                                    Text(
                                      setDateFormat(walletController
                                          .wallet.walletCreatedAt),
                                      style: smallRegular,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Terakhir Update",
                                      style: smallRegular,
                                    ),
                                    Text(
                                      setDateFormat(walletController
                                          .wallet.walletUpdatedAt),
                                      style: smallRegular,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Status",
                                      style: smallRegular,
                                    ),
                                    Text(
                                      walletController.wallet.walletIsActive!
                                          ? "Aktif"
                                          : "Tidak Aktif",
                                      style: smallRegular.copyWith(
                                        color: walletController
                                                .wallet.walletIsActive!
                                            ? variantCactus
                                            : primaryWater,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Member",
                          style: contentSemiBold,
                        ),
                        ButtonText(
                          text: "Tambah Member",
                          textColor: primaryWater,
                          icon: const Icon(
                            Icons.add,
                            color: primaryWater,
                            size: 16,
                          ),
                          onTap: () {
                            Get.toNamed(
                              "/wallet_member_add",
                              arguments: {
                                "wallet_id": walletController.wallet.walletId,
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      if (homeController.isLoadingMember.value) {
                        return const ShimmerLoadingTransaction();
                      }
                      return Container(
                        child: homeController.listmember.isEmpty
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No Member Found",
                                    style: contentRegular),
                              ))
                            : Expanded(
                                child: ListView(
                                  children: homeController.listmember
                                      .map<Widget>((e) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MemberCard(
                                          userPhoto: e.userPhoto,
                                          userName: e.userName,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.userName!,
                                              style: contentRegular,
                                            ),
                                            Text(
                                              e.userPhone!,
                                              style: smallRegular,
                                            ),
                                            Text(
                                              e.userEmail!,
                                              style: smallRegular,
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
