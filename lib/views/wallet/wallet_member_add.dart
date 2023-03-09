import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/wallet_controller.dart';
import 'package:getx/models/wallet_model.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/utils/custom_dialog.dart';
import 'package:getx/utils/form_validation.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/input_text_field.dart';
import 'package:getx/views/widgets/member_card.dart';
import 'package:getx/views/widgets/message_error.dart';
import 'package:getx/views/widgets/shimmer_loading.dart';
import 'package:lottie/lottie.dart';

class WalletMemberAdd extends StatefulWidget {
  const WalletMemberAdd({Key? key}) : super(key: key);

  @override
  State<WalletMemberAdd> createState() => _WalletMemberAddState();
}

class _WalletMemberAddState extends State<WalletMemberAdd> {
  final WalletController walletController = Get.put(WalletController());
  int? walletId = 0;
  List<Map<String, dynamic>> responseAddMember = [];
  @override
  void initState() {
    walletId = Get.arguments['wallet_id'];
    walletController.getMemberForWallet({
      "wallet_id": walletId,
      "keyword": walletController.walletKeyword.value.text,
    });
    super.initState();
  }

  void doAddMember(WalletForMemberModel e) {
    FocusScope.of(context).requestFocus(FocusNode());
    walletController.handleAddMemberWallet({
      "ow_wallet_id": "$walletId",
      "ow_member_id": "${e.userId}",
    });
  }

  doLoading() {
    Get.back();
    Get.defaultDialog(
      title: "Menunggu",
      titleStyle: subtitleSemiBold,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            "assets/lottie/sending.json",
            width: Get.width * .5,
            height: Get.width * .5,
          ),
          Text("Sabar,ya~", style: contentRegular),
        ],
      ),
    );
  }

  void addMember(WalletForMemberModel e) {
    CustomDialog().yesOrNoDialog(
      onTapYes: () {
        doLoading();
        Future.delayed(const Duration(seconds: 1), () {
          doAddMember(e);
          walletController.listForMemberAdd.add(e);
        });
      },
      onTapNo: () => Get.back(),
      question: "Undang sebagai member?",
      type: "info",
    );
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: primaryWater,
                            ),
                          ),
                          Text(
                            "Temukan Member",
                            style: subtitleSemiBold,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        walletController
                            .isSearch(!walletController.isSearch.value);
                        if (walletController.isSearch.isFalse) {
                          walletController.walletKeyword.value.text = "";
                        }
                      },
                      child: Icon(
                        walletController.isSearch.isTrue
                            ? Icons.clear
                            : Icons.search_outlined,
                        color: primaryWater,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                walletController.isSearch.isFalse
                    ? const SizedBox()
                    : InputTextField(
                        hintText: "Masukkan Nama, Email, atau No. Hp",
                        controller: walletController.walletKeyword.value,
                        suffixIcon: const Icon(
                          Icons.search_outlined,
                          color: primaryWater,
                        ),
                        validator: validationString,
                        onChanged: (v) => setState(() {
                          walletController.onSearchChanged(
                            walletId: walletId,
                          );
                        }),
                      ),
                Expanded(
                  child: Obx(() {
                    if (walletController.isLoadingSearch.value) {
                      return ListView(
                        children: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
                            .map<Widget>(
                                (_) => const ShimmerLoadingTransaction())
                            .toList(),
                      );
                    }
                    return walletController.isErrorSearch.value
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                "assets/lottie/not_found.json",
                                width: s.width * .5,
                                height: s.width * .5,
                              ),
                              MessageError(
                                message: walletController.errorSearch.value,
                                onTap: () {
                                  walletController.onSearchChanged(
                                    walletId: walletId,
                                  );
                                },
                              )
                            ],
                          )
                        : walletController.listForMember.isEmpty
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No Member Found",
                                    style: contentRegular),
                              ))
                            : ListView(
                                children: walletController.listForMember
                                    .map<Widget>((e) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    leading: MemberCard(
                                      userPhoto: e.userPhoto,
                                      userName: e.userName,
                                    ),
                                    title: Text(
                                      e.userName!,
                                      style: contentRegular,
                                    ),
                                    subtitle: Text(
                                      e.userEmail!,
                                      style: contentRegular,
                                    ),
                                    trailing: InkWell(
                                      onTap: () {
                                        setState(() {
                                          addMember(e);
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add_circle_outline,
                                        color: variantCactus,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                  }),
                ),
                walletController.listForMemberAdd.isEmpty
                    ? const SizedBox()
                    : ButtonPrimary(
                        text: "Selesai",
                        bgColor: primaryWater,
                        hvColor: primaryWaterLight,
                        onTap: () {
                          Get.offNamed(
                            "/main_menu",
                            arguments: {"isNew": false, "isReload": true},
                          );
                        },
                      ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
