import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/models/wallet_model.dart';
import 'package:getx/themes/fonts.dart';

class WalletCard extends StatefulWidget {
  const WalletCard(
      {Key? key, required this.walletModel, required this.isCreate})
      : super(key: key);
  final WalletModel? walletModel;
  final bool? isCreate;
  @override
  _WalletCardState createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  final currencyFormatter = CurrencyTextInputFormatter(
    name: "",
    locale: "ID",
    decimalDigits: 0,
  );
  WalletModel? walletModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            "assets/png/cards_${widget.walletModel!.walletColor}.png",
            height: 200,
            width: 320,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          height: 200,
          width: 320,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.walletModel!.walletName!,
                      style: contentSemiBold.copyWith(color: Colors.white),
                    ),
                  ),
                  Text(
                    "OW Card",
                    style: contentSemiBold.copyWith(color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              widget.isCreate!
                  ? const SizedBox()
                  : Text(
                      'Rp ${currencyFormatter.format("${widget.walletModel!.walletMoney!}")}',
                      style: titleSemiBold.copyWith(color: Colors.white),
                    ),
              const Spacer(),
              widget.isCreate!
                  ? const SizedBox()
                  : Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              "/wallet_detail",
                              arguments: {"wallet": widget.walletModel},
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: Text(
                                "Detail",
                                style: contentRegular,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
            ],
          ),
        )
      ],
    );
  }
}
