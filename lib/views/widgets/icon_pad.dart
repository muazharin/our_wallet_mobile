import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/themes/fonts.dart';
import 'package:lottie/lottie.dart';

class IconPad extends StatefulWidget {
  const IconPad({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final Widget? icon;
  final String? text;
  final Function()? onTap;

  @override
  State<IconPad> createState() => _IconPadState();
}

class _IconPadState extends State<IconPad> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap ??
          () {
            Get.defaultDialog(
              title: "Perhatian",
              titleStyle: subtitleSemiBold,
              contentPadding: const EdgeInsets.all(16),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    "assets/lottie/development.json",
                    width: s.width * .5,
                    height: s.width * .5,
                    repeat: false,
                  ),
                  Text(
                    "Ups!!",
                    style: subtitleRegular,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "yang ini lagi dalam pengembangan",
                    style: contentRegular,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 16,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: widget.icon!),
        ),
      ),
    );
  }
}
