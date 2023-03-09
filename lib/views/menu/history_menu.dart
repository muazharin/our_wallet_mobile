import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/trans_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/message_error.dart';
import 'package:getx/views/widgets/shimmer_loading.dart';
import 'package:getx/views/widgets/transaction_card.dart';
import 'package:lottie/lottie.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TransController transController = Get.put(TransController());
  String title = "History";

  @override
  void initState() {
    transController.listHistory = [];
    transController.getHistory();
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
          "History",
          style: subtitleSemiBold.copyWith(color: primaryWater),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: Obx(() {
            if (transController.isLoadingHistory.value) {
              return ListView(
                children: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
                    .map<Widget>((_) => const ShimmerLoadingTransaction())
                    .toList(),
              );
            } else if (transController.isErrorHistory.isTrue) {
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
                      message: transController.errorHistory.value,
                      onTap: () {
                        transController.getHistory();
                      },
                    )
                  ],
                ),
              );
            } else if (transController.listtransactionUser.isEmpty) {
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
              child: ListView(
                children: transController.listHistory.map<Widget>((e) {
                  return Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        e.name!,
                        style: smallSemiBold,
                      ),
                      Column(
                        children: e.riwayat!.map<Widget>((es) {
                          return TransactionCard(
                            transactionModel: es,
                          );
                        }).toList(),
                      )
                    ],
                  );
                }).toList(),
              ),
            );
          }),
        ),
      ),
    );
  }
}
