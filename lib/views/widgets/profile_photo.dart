import 'package:flutter/material.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    Key? key,
    required this.photo,
    required this.name,
    this.size,
  }) : super(key: key);
  final String? photo;
  final String? name;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: photo == ""
          ? ClipOval(
              child: Container(
                width: size ?? 56,
                height: size ?? 56,
                color: primaryWater,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      name![0].toUpperCase(),
                      style: contentSemiBold.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          : ClipOval(
              child: Image.network(
                photo!,
                width: size ?? 56,
                height: size ?? 56,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
