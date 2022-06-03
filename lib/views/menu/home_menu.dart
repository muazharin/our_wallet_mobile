import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/home_controller.dart';
import 'package:getx/controllers/profile_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/button_text.dart';
import 'package:getx/views/widgets/member_card.dart';
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

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() {
    if (homeController.dataLocal.isEmpty) {
      homeController.getLocalData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Get.defaultDialog(
                title: "Keluar",
                titleStyle: subtitleSemiBold,
                middleText: "Yakin ingin keluar?",
                middleTextStyle: contentRegular,
                radius: 12,
                cancel: ButtonPrimary(
                  text: "Keluar",
                  onTap: () => profileController.setLocalStorage(),
                ),
                confirm: ButtonPrimary(
                  text: "Batal",
                  textColor: primaryBlood,
                  bgColor: primaryBloodLight,
                  onTap: () => Get.back(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.exit_to_app, color: primaryBlood),
            ),
          )
        ],
        title: Text("Our Wallet App", style: subtitleSemiBold),
      ),
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
                      Text(
                        "Halo, ${homeController.dataLocal['username']} :)",
                      ),
                      const SizedBox(height: 16),
                      homeController.list.isEmpty
                          ? WalletAddCard(
                              onTap: () {
                                Get.toNamed("/wallet_add")?.then((_) {
                                  homeController.getLocalData();
                                });
                              },
                            )
                          : SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                    child: WalletCard(
                                      walletModel: homeController.list[index],
                                    ),
                                  );
                                },
                                onIndexChanged: (i) {
                                  homeController.onIndexChanged(i);
                                },
                                itemCount: homeController.list.length,
                                itemWidth: MediaQuery.of(context).size.width,
                                itemHeight: 200.0,
                                layout: homeController.list.length < 3
                                    ? SwiperLayout.DEFAULT
                                    : SwiperLayout.TINDER,
                              ),
                            ),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Members", style: smallSemiBold),
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
                  if (homeController.isLoadingMember.value) {
                    return const ShimmerLoadingMember();
                  }
                  return Container(
                    child: homeController.listmember.isEmpty
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text("No Member Found", style: contentRegular),
                          ))
                        : Row(
                            children: homeController.listmember
                                .map<Widget>(
                                    (e) => MemberCard(memberWalletModel: e))
                                .toList(),
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
                        Text("Transaksi Terakhir", style: smallSemiBold),
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
                    child: homeController.listtransaction.isEmpty
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
      ),
    );
  }
}
