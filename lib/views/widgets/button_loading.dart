import 'package:flutter/material.dart';
import 'package:getx/themes/colors.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({
    Key? key,
    this.bgColor,
  }) : super(key: key);
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor ?? primaryBlood,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: const Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
