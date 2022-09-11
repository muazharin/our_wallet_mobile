import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/home_controller.dart';
import 'package:getx/controllers/profile_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/utils/custom_dialog.dart';
import 'package:getx/views/widgets/button_text.dart';
import 'package:getx/views/widgets/icon_pad.dart';
import 'package:getx/views/widgets/member_card.dart';
import 'package:getx/views/widgets/message_error.dart';
import 'package:getx/views/widgets/shimmer_loading.dart';
import 'package:getx/views/widgets/transaction_card.dart';
import 'package:getx/views/widgets/wallet_add_card.dart';
import 'package:getx/views/widgets/wallet_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ProfileController profileController = Get.put(ProfileController());
  final HomeController homeController = Get.put(HomeController());
  String title = "Home";
  bool isNew = false;
  bool isReload = false;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() {
    setState(() {
      isNew = Get.arguments['isNew'];
      isReload = Get.arguments['isReload'];
    });
    if (isNew) {
      Future.delayed(const Duration(seconds: 3), () {
        CustomDialog().yesOrNoDialog(
          title: "Info Pengguna Baru",
          onTapYes: () {
            Get.back();
            Get.toNamed("/wallet_add");
          },
          onTapNo: () => Get.back(),
          question: "Buat walletmu sekarang?",
          yes: "Ok",
          no: "Nanti aja",
          type: "info",
        );
      });
    }
    if (isReload) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        homeController.getLocalData();
        setState(() {
          Get.arguments['isReload'] = false;
        });
      });
    }
    if (homeController.dataLocal.isEmpty) {
      homeController.getLocalData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          homeController.getLocalData();
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (homeController.isLoadingCard.value) {
                    return const ShimmerLoading.rectangular(
                      height: 200,
                      radius: 12,
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: primaryBlood,
                            width: 36,
                            height: 36,
                            child: homeController.dataLocal['photo'] != ""
                                ? Image.network(
                                    homeController.dataLocal['photo'],
                                    fit: BoxFit.cover,
                                  )
                                : Center(
                                    child: Text(
                                      homeController.dataLocal['username'][0]
                                          .toString()
                                          .toUpperCase(),
                                      style: smallSemiBold.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                          ),
                        ),
                        title: Text(
                          homeController.dataLocal['username'],
                          style: contentRegular,
                        ),
                        subtitle: Text(
                          homeController.dataLocal['email'],
                          style: smallRegular,
                        ),
                        trailing: InkWell(
                          onTap: () {
                            CustomDialog().yesOrNoDialog(
                              onTapYes: () =>
                                  profileController.setLocalStorage(),
                              onTapNo: () => Get.back(),
                              question: "Yakin ingin keluar?",
                              type: "warning",
                            );
                          },
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            color: primaryBlood,
                          ),
                        ),
                      ),
                      homeController.isErrorList.isTrue
                          ? WalletAddCard(
                              onTap: () {},
                              message: MessageError(
                                  message: homeController.errorList.value,
                                  onTap: () {
                                    homeController.isErrorList.value = false;
                                    homeController.getLocalData();
                                  }),
                            )
                          : homeController.list.isEmpty
                              ? WalletAddCard(
                                  onTap: () {
                                    Get.toNamed("/wallet_add")?.then((_) {
                                      homeController.isErrorList.value = false;
                                      homeController.getLocalData();
                                    });
                                  },
                                )
                              : SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Center(
                                        child: WalletCard(
                                          isCreate: false,
                                          walletModel:
                                              homeController.list[index],
                                        ),
                                      );
                                    },
                                    onIndexChanged: (i) {
                                      homeController.isErrorList.value = false;
                                      homeController.onIndexChanged(i);
                                    },
                                    physics: homeController.list.length < 2
                                        ? const NeverScrollableScrollPhysics()
                                        : const ScrollPhysics(),
                                    itemCount: homeController.list.length,
                                    itemWidth:
                                        MediaQuery.of(context).size.width,
                                    itemHeight: 200.0,
                                    layout: SwiperLayout.DEFAULT,
                                  ),
                                ),
                      const SizedBox(height: 8),
                      homeController.list.length < 2
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: homeController.list
                                  .asMap()
                                  .entries
                                  .map<Widget>((e) {
                                return InkWell(
                                  child: Container(
                                    width: homeController.index.value == e.key
                                        ? 24.0
                                        : 8.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                      color: homeController.index.value == e.key
                                          ? primaryBlood
                                          : grayscaleStone,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                      const SizedBox(height: 8),
                      homeController.list.isEmpty
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconPad(
                                  icon: Image.asset(
                                    "assets/png/topup.png",
                                    color: primaryBlood,
                                  ),
                                  text: "Top Up",
                                  onTap: () => Get.toNamed(
                                    "/trans_topup",
                                    arguments: {
                                      "wallet_id": homeController
                                          .list[homeController.index.value]
                                          .walletId
                                    },
                                  ),
                                ),
                                IconPad(
                                  icon: Image.asset(
                                    "assets/png/payment.png",
                                    color: primaryBlood,
                                  ),
                                  text: "Payment",
                                  onTap: () => Get.toNamed(
                                    "/trans_shop",
                                    arguments: {
                                      "wallet_id": homeController
                                          .list[homeController.index.value]
                                          .walletId
                                    },
                                  ),
                                ),
                                IconPad(
                                  icon: Image.asset(
                                    "assets/png/barchart.png",
                                    color: primaryBlood,
                                  ),
                                  text: "Statistic",
                                  // onTap: () {},
                                ),
                                IconPad(
                                  icon: Image.asset(
                                    "assets/png/invitation.png",
                                    color: primaryBlood,
                                  ),
                                  text: "Invitation",
                                  onTap: () {
                                    Get.toNamed(
                                      "/wallet_member_add",
                                      arguments: {
                                        "wallet_id": homeController
                                            .list[homeController.index.value]
                                            .walletId,
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Members", style: smallSemiBold),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Obx(() {
                          if (homeController.isLoadingMember.value) {
                            return const ShimmerLoadingMember();
                          }
                          return Container(
                            child: homeController.isErrorListMember.isTrue
                                ? MessageError(
                                    message:
                                        homeController.errorListMember.value,
                                    onTap: () {
                                      homeController.isErrorListMember(false);
                                      homeController.getMemberWallet({
                                        'wallet_id': homeController
                                            .list[homeController.index.value]
                                            .walletId
                                      });
                                    },
                                  )
                                : homeController.listmember.isEmpty
                                    ? Center(
                                        child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("No Member Found",
                                            style: contentRegular),
                                      ))
                                    : SizedBox(
                                        height: 64,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: homeController
                                                    .listmember
                                                    .map<Widget>(
                                                      (e) => MemberCard(
                                                        userPhoto: e.userPhoto,
                                                        userName: e.userName,
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                width: 48,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(48),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 16,
                                                      offset:
                                                          const Offset(1, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: primaryBlood,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                          );
                        }),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Transaksi Terakhir",
                                    style: smallSemiBold),
                                ButtonText(
                                  text: "Selengkapnya",
                                  textColor: primaryBlood,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Obx(() {
                          if (homeController.isLoadingTransaction.value) {
                            return const ShimmerLoadingTransaction();
                          }
                          return Container(
                            child: homeController.isErrorListTransaction.isTrue
                                ? MessageError(
                                    message: homeController
                                        .errorListTransaction.value,
                                    onTap: () {
                                      homeController
                                          .isErrorListTransaction(false);
                                      homeController.getLastTransaction({
                                        'walletId': homeController
                                            .list[homeController.index.value]
                                            .walletId
                                      });
                                    },
                                  )
                                : homeController.listtransaction.isEmpty
                                    ? Center(
                                        child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("No Transaction Found",
                                            style: contentRegular),
                                      ))
                                    : Column(
                                        children: homeController.listtransaction
                                            .map<Widget>((e) => TransactionCard(
                                                  transactionModel: e,
                                                ))
                                            .toList(),
                                      ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
