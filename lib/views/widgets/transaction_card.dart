import 'package:flutter/material.dart';
import 'package:getx/models/transaction_model.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/profile_photo.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    Key? key,
    this.transactionModel,
  }) : super(key: key);
  final TransactionModel? transactionModel;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  final currencyFormatter = NumberFormat("#,##0", "id_ID");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => DetailTransaction(
            //     transactionModel: transactionModel,
            //   ),
            // ));
          },
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: widget.transactionModel!.transUser == null
                ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/png/cards_${widget.transactionModel!.transWallet!.transWalletColor!}.png",
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.centerRight,
                      width: 40,
                      height: 125,
                    ),
                  )
                : ProfilePhoto(
                    photo: widget.transactionModel!.transUser!.transUserPhoto,
                    name: widget.transactionModel!.transUser!.transUserName,
                    size: 48,
                  ),
            title: widget.transactionModel!.transUser == null
                ? Text(
                    widget.transactionModel!.transWallet!.transWalletName!,
                    style: smallRegular,
                  )
                : Text(
                    widget.transactionModel!.transUser!.transUserName!,
                    style: smallRegular,
                  ),
            subtitle: Text(
              DateFormat("dd MMM yy HH:mm")
                  .format(widget.transactionModel!.transDate!),
              style: smallRegular,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.transactionModel!.transType!,
                  style: smallRegular,
                ),
                const SizedBox(height: 4),
                widget.transactionModel!.transType == "Kredit"
                    ? Text(
                        '+ Rp ${currencyFormatter.format(widget.transactionModel!.transPrice!)}',
                        style: smallSemiBold.copyWith(color: variantCactus),
                      )
                    : Text(
                        '- Rp ${currencyFormatter.format(widget.transactionModel!.transPrice!)}',
                        style: smallSemiBold.copyWith(color: variantSunflower),
                      ),
              ],
            ),
          ),
        ),
        Container(
          height: 4,
          color: grayscaleStoneLightest,
        )
      ],
    );
  }
}
