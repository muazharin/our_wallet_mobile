import 'package:flutter/material.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';

class ButtonPrimary extends StatefulWidget {
  const ButtonPrimary({
    Key? key,
    this.bgColor = primaryBlood,
    this.hvColor = primaryBloodLight,
    this.textColor = Colors.white,
    this.textSize = 14,
    this.radius = 12,
    this.padding = 16,
    this.text = "",
    this.onTap,
  }) : super(key: key);
  final Color bgColor;
  final Color hvColor;
  final Color textColor;
  final double textSize;
  final double radius;
  final double padding;
  final String text;
  final Function()? onTap;

  @override
  State<ButtonPrimary> createState() => _ButtonPrimaryState();
}

class _ButtonPrimaryState extends State<ButtonPrimary> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.bgColor,
      borderRadius: BorderRadius.circular(widget.radius),
      child: InkWell(
        onTap: widget.onTap,
        splashColor: widget.hvColor,
        child: Padding(
          padding: EdgeInsets.all(widget.padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  widget.text,
                  style: contentSemiBold.copyWith(
                    color: widget.textColor,
                    fontSize: widget.textSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
