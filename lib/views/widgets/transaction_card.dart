import 'package:flutter/material.dart';
import 'package:getx/models/transaction_model.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';
import 'package:getx/views/widgets/profile_photo.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({Key? key, this.transactionModel}) : super(key: key);
  final TransactionModel? transactionModel;
  final currencyFormatter = NumberFormat("#,##0", "id_ID");
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => DetailTransaction(
        //     transactionModel: transactionModel,
        //   ),
        // ));
      },
      child: ListTile(
        leading: ProfilePhoto(
          photo: transactionModel!.userDetail!.photo,
          name: transactionModel!.userDetail!.name,
          size: 48,
        ),
        title: Text(
          transactionModel!.userDetail!.name!,
          style: smallRegular,
        ),
        subtitle: Text(
          DateFormat("dd MMM yy hh:mm")
              .format(transactionModel!.transactionDetail!.date!),
          style: smallRegular,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              transactionModel!.type!,
              style: smallRegular,
            ),
            const SizedBox(height: 4),
            transactionModel!.type == "Kredit"
                ? Text(
                    '+ Rp ${currencyFormatter.format(double.parse(transactionModel!.transactionDetail!.price!))}',
                    style: smallSemiBold.copyWith(color: variantCactus),
                  )
                : Text(
                    '+ Rp ${currencyFormatter.format(double.parse(transactionModel!.transactionDetail!.price!))}',
                    style: smallSemiBold.copyWith(color: variantSunflower),
                  ),
          ],
        ),
      ),
    );
  }
}
