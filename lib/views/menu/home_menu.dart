import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/home_controller.dart';
import 'package:getx/controllers/profile_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/button_text.dart';
import 'package:getx/views/widgets/icon_pad.dart';
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
                            Get.defaultDialog(
                              title: "Keluar",
                              titleStyle: subtitleSemiBold,
                              middleText: "Yakin ingin keluar?",
                              middleTextStyle: contentRegular,
                              radius: 12,
                              cancel: ButtonPrimary(
                                text: "Keluar",
                                onTap: () =>
                                    profileController.setLocalStorage(),
                              ),
                              confirm: ButtonPrimary(
                                text: "Batal",
                                textColor: primaryBlood,
                                bgColor: primaryBloodLight,
                                onTap: () => Get.back(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            color: primaryBlood,
                          ),
                        ),
                      ),
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
                                physics: homeController.list.length < 2
                                    ? const NeverScrollableScrollPhysics()
                                    : const ScrollPhysics(),
                                itemCount: homeController.list.length,
                                itemWidth: MediaQuery.of(context).size.width,
                                itemHeight: 200.0,
                                layout: homeController.list.length < 3
                                    ? SwiperLayout.DEFAULT
                                    : SwiperLayout.TINDER,
                              ),
                            ),
                      const SizedBox(height: 16),
                      homeController.list.isEmpty
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconPad(
                                  icon: Image.asset(
                                    "assets/png/topup.png",
                                  ),
                                  text: "Top Up",
                                ),
                                IconPad(
                                  icon: Image.asset(
                                    "assets/png/payment.png",
                                  ),
                                  text: "Payment",
                                ),
                                IconPad(
                                  icon: Image.asset(
                                    "assets/png/barchart.png",
                                  ),
                                  text: "Statistic",
                                ),
                                IconPad(
                                  icon: Image.asset(
                                    "assets/png/invitation.png",
                                  ),
                                  text: "Invitation",
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
                            ButtonText(
                              text: "Selengkapnya",
                              textColor: primaryBlood,
                              onTap: () {},
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
                                    child: Text("No Member Found",
                                        style: contentRegular),
                                  ))
                                : SizedBox(
                                    height: 96,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: homeController.listmember
                                          .map<Widget>((e) =>
                                              MemberCard(memberWalletModel: e))
                                          .toList(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
