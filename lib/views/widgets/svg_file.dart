import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getx/utils/constant.dart';

class SvgFile extends StatelessWidget {
  const SvgFile({Key? key, required this.filename}) : super(key: key);
  final String? filename;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "${svgpath!}${filename!}",
      width: 150,
      height: 150,
    );
  }
}
