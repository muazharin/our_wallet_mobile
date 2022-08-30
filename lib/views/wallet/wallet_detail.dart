import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/wallet_controller.dart';
import 'package:getx/themes/fonts.dart';
import 'package:intl/intl.dart';

class WalletDetail extends StatefulWidget {
  const WalletDetail({Key? key}) : super(key: key);

  @override
  State<WalletDetail> createState() => _WalletDetailState();
}

class _WalletDetailState extends State<WalletDetail> {
  final WalletController walletController = Get.put(WalletController());
  final currencyFormatter = NumberFormat("#,##0", "id_ID");
  @override
  void initState() {
    setInit();
    super.initState();
  }

  setInit() {
    walletController.wallet = Get.arguments['wallet'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Detail",
                style: subtitleSemiBold,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ListView(
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
                            height: 120,
                            width: 70,
                            child: Image.asset(
                              "assets/png/cards_${walletController.wallet.walletColor}.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              walletController.wallet.walletName!,
                              style: contentSemiBold,
                            ),
                            Text(
                              'Rp ${currencyFormatter.format(walletController.wallet.walletMoney!)}',
                              style: contentRegular,
                            ),
                            Text(
                              walletController.wallet.walletCreatedAt
                                  .toString(),
                              style: contentRegular,
                            ),
                            Text(
                              walletController.wallet.walletUpdatedAt
                                  .toString(),
                              style: contentRegular,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
