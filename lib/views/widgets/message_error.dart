import 'package:flutter/material.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/views/widgets/button_text.dart';

class MessageError extends StatelessWidget {
  const MessageError({
    Key? key,
    required this.message,
    required this.onTap,
  }) : super(key: key);
  final String? message;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message ?? ""),
        ButtonText(
          text: "Coba lagi",
          textColor: primaryWater,
          onTap: onTap ?? () {},
        )
      ],
    );
  }
}
