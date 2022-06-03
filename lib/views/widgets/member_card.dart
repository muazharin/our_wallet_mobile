import 'package:flutter/material.dart';
import 'package:getx/models/wallet_model.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({Key? key, required this.memberWalletModel})
      : super(key: key);
  final MemberWalletModel? memberWalletModel;
  @override
  _MemberCardState createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 16,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              widget.memberWalletModel!.userPhoto == ''
                  ? ClipOval(
                      child: Container(
                        height: 56,
                        width: 56,
                        color: primaryBlood,
                        child: Center(
                          child: Text(
                            widget.memberWalletModel!.userName!
                                .substring(0, 1)
                                .toUpperCase(),
                            style: contentRegular,
                          ),
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Image.network(
                        widget.memberWalletModel!.userPhoto!,
                        height: 56,
                        width: 56,
                        fit: BoxFit.contain,
                      ),
                    ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
