import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final ShapeBorder shapeBorder;

  // ignore: use_key_in_widget_constructors
  const ShimmerLoading.rectangular({
    this.width = double.infinity,
    required this.radius,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  // ignore: use_key_in_widget_constructors
  const ShimmerLoading.circular({
    this.width = double.infinity,
    required this.radius,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            shape: shapeBorder,
            color: Colors.grey[400]!,
          ),
        ),
      ),
    );
  }
}

class ShimmerLoadingMember extends StatelessWidget {
  const ShimmerLoadingMember({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 16,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            ShimmerLoading.circular(radius: 0, height: 56, width: 56),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ShimmerLoadingTransaction extends StatelessWidget {
  const ShimmerLoadingTransaction({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: ShimmerLoading.circular(
        radius: 0,
        height: 48,
        width: 48,
      ),
      title: ShimmerLoading.rectangular(
        radius: 4,
        height: 12,
        width: 56,
      ),
      subtitle: ShimmerLoading.rectangular(
        radius: 4,
        height: 12,
        width: 56,
      ),
      // trailing: Column(
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     TextRegular(text: transactionModel!.type),
      //     SizedBox(height: 4),
      //     transactionModel!.type == "Kredit"
      //         ? TextBold(
      //             text:
      //                 '+ Rp ${currencyFormatter.format(double.parse(transactionModel!.transactionDetail!.price!))}',
      //             color: variantCactus,
      //           )
      //         : TextBold(
      //             text:
      //                 '- Rp ${currencyFormatter.format(double.parse(transactionModel!.transactionDetail!.price!))}',
      //             color: variantSunflower,
      //           ),
      //   ],
      // ),
    );
  }
}
