import 'package:flutter/material.dart';
import 'package:getx/themes/fonts.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    Key? key,
    this.onTap,
    this.icon,
    this.text = "",
    this.textColor = Colors.white,
  }) : super(key: key);
  final Function()? onTap;
  final Widget? icon;
  final String text;
  final Color textColor;
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
