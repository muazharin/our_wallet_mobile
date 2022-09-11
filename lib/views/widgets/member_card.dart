import 'package:flutter/material.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({
    Key? key,
    required this.userPhoto,
    required this.userName,
  }) : super(key: key);
  // final MemberWalletModel? memberWalletModel;
  final String? userPhoto;
  final String? userName;
  @override
  _MemberCardState createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          widget.userPhoto == ''
              ? ClipOval(
                  child: Container(
                    height: 48,
                    width: 48,
                    color: primaryBlood,
                    child: Center(
                      child: Text(
                        widget.userName![0].toUpperCase(),
                        style: contentSemiBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : ClipOval(
                  child: Image.network(
                    widget.userPhoto!,
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
