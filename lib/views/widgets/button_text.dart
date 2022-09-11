import 'package:flutter/material.dart';
import 'package:getx/themes/fonts.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    this.onTap,
    this.icon,
    this.text = "",
    this.textSize = 12,
    this.textColor = Colors.white,
  }) : super(key: key);
  final Function()? onTap;
  final Widget? icon;
  final String text;
  final Color textColor;
  final double? textSize;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? const SizedBox.shrink(),
            Text(
              text,
              style: smallSemiBold.copyWith(
                color: textColor,
                fontSize: textSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
