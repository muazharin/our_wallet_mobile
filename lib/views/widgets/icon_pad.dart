import 'package:flutter/material.dart';

class IconPad extends StatelessWidget {
  const IconPad({Key? key, this.icon, this.text}) : super(key: key);
  final Widget? icon;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
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
        child: Center(child: icon!),
      ),
    );
  }
}
