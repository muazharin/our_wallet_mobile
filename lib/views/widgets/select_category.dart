import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/trans_controller.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/transaction/trans_category.dart';
import 'package:getx/views/widgets/button_primary.dart';
import 'package:getx/views/widgets/button_text.dart';
import 'package:getx/views/widgets/message_error.dart';
import 'package:lottie/lottie.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({
    Key? key,
    required this.walletId,
    required this.tempId,
    required this.tempGroupList,
    required this.type,
  }) : super(key: key);
  final int? walletId;
  final int? tempId;
  final String? tempGroupList;
  final String? type;

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  final TransController transController = Get.put(TransController());
  var tempId = 0.obs;
  var tempGropList = "".obs;
  var data = {};
  @override
  void initState() {
    setInit();
    super.initState();
  }

  setInit() {
    tempId(widget.tempId);
    tempGropList(widget.tempGroupList!);
    data = {
      "type": widget.type,
      "walletId": "${widget.walletId}",
    };
    transController.getCategory(data);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: transController.isLoadingCategory.value
            ? const Center(child: CircularProgressIndicator())
            : transController.isErrorCategory.value
                ? MessageError(
                    message: transController.errorCategory.value,
                    onTap: () {
                      setInit();
                    },
                  )
                : transController.listCategory.isEmpty
                    ? Center(
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
                            const SizedBox(height: 8),
                            ButtonText(
                              text: "Tambah data",
                              textColor: primaryWater,
                              icon: const Icon(
                                Icons.add,
                                color: primaryWater,
                                size: 14,
                              ),
                              onTap: () => Get.to(
                                      TransCategory(type: widget.type),
                                      arguments: {
                                    "wallet_id": widget.walletId,
                                    "aksi": "Tambah",
                                    "category_id": tempId.value,
                                    "category_name": tempGropList.value,
                                  })!
                                  .then((v) {
                                if (v) setInit();
                              }),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 4,
                                width: 40,
                                color: grayscaleStone,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView(
                                children: transController.listCategory
                                    .map<Widget>((e) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        tempId.value = e.categoryId!;
                                        tempGropList(e.categoryTitle);
                                      });
                                    },
                                    child: ListTile(
                                      title: Text(
                                        e.categoryTitle!,
                                        style: contentRegular,
                                      ),
                                      trailing:
                                          tempGropList.value != e.categoryTitle
                                              ? const SizedBox()
                                              : const Icon(
                                                  Icons.circle,
                                                  color: variantCactus,
                                                  size: 14,
                                                ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            ButtonPrimary(
                              text: "Pilih",
                              textColor: Colors.white,
                              bgColor: tempGropList.value == ""
                                  ? primaryWaterLight
                                  : primaryWater,
                              hvColor: tempGropList.value == ""
                                  ? Colors.white
                                  : primaryWaterLight,
                              onTap: () {
                                setState(() {
                                  Get.back();
                                  transController.categoryId(tempId.value);
                                  transController.transCategory.value.text =
                                      tempGropList.value;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            ButtonText(
                              text: tempGropList.value == ""
                                  ? "Tambah Data"
                                  : "Ubah Data",
                              textColor: primaryWater,
                              textSize: 14,
                              onTap: () {
                                if (tempGropList.value == "") {
                                  Get.to(
                                    TransCategory(type: widget.type),
                                    arguments: {
                                      "wallet_id": widget.walletId,
                                      "aksi": "Tambah",
                                      "category_id": tempId.value,
                                      "category_name": tempGropList.value,
                                    },
                                  )!
                                      .then((v) {
                                    if (v) setInit();
                                  });
                                } else {
                                  Get.to(
                                    TransCategory(type: widget.type),
                                    arguments: {
                                      "wallet_id": widget.walletId,
                                      "aksi": "Update",
                                      "category_id": tempId.value,
                                      "category_name": tempGropList.value,
                                    },
                                  )!
                                      .then((v) {
                                    if (v) setInit();
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
      );
    });
  }
}
