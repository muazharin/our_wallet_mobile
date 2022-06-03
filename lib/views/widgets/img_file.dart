import 'package:flutter/material.dart';
import 'package:getx/utils/constant.dart';

class ImgFile extends StatelessWidget {
  const ImgFile({Key? key, required this.filename}) : super(key: key);
  final String? filename;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "${pngpath!}${filename!}",
      width: 150,
      height: 150,
    );
  }
}
