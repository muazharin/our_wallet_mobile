import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/wallet_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/message_error.dart';
import 'package:getx/views/widgets/shimmer_loading.dart';
import 'package:getx/views/widgets/wallet_card.dart';
import 'package:lottie/lottie.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final WalletController walletController = Get.put(WalletController());
  String title = "Cards";

  @override
  void initState() {
    walletController.getOurWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Cards",
          style: subtitleSemiBold.copyWith(color: primaryWater),
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                walletController.walletName.value.text = "";
                walletController.walletMoney.value.text = "";
                Get.toNamed("/wallet_add")!.then((v) {
                  if (v is bool) {
                    walletController.getOurWallet();
                  } else {
                    print("null");
                  }
                });
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.add,
                color: primaryWater,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            walletController.getOurWallet();
          },
          child: Obx(() {
            if (walletController.isLoading.value) {
              return ListView(
                children: [1, 1, 1, 1, 1].map<Widget>((e) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ShimmerLoading.rectangular(radius: 12, height: 200),
                  );
                }).toList(),
              );
            } else if (walletController.isErrorList.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/lottie/error.json",
                      width: Get.width * .5,
                      height: Get.width * .5,
                      repeat: false,
                    ),
                    MessageError(
                      message: walletController.errorList.value,
                      onTap: () {
                        walletController.getOurWallet();
                      },
                    )
                  ],
                ),
              );
            } else if (walletController.list.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/lottie/not_found.json",
                      width: Get.width * .5,
                      height: Get.width * .5,
                      repeat: false,
                    ),
                    Text("No data found", style: contentRegular),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                children: walletController.list.map<Widget>((e) {
                  return WalletCard(walletModel: e, isCreate: false);
                }).toList(),
              ),
            );
          }),
        ),
      ),
    );
  }
}
