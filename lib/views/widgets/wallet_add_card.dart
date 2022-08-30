import 'package:flutter/material.dart';
import 'package:getx/themes/colors.dart';

class WalletAddCard extends StatelessWidget {
  const WalletAddCard({
    Key? key,
    this.onTap,
    this.message,
  }) : super(key: key);
  final Function()? onTap;
  final Widget? message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 200,
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: grayscaleStone,
          ),
          child: Center(
            child: message ??
                const Icon(
                  Icons.add,
                  color: grayscaleStoneLight,
                  size: 48,
                ),
          ),
        ),
      ),
    );
  }
}
