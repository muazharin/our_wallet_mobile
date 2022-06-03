import 'package:flutter/material.dart';
import 'package:getx/themes/colors.dart';
import 'package:getx/themes/fonts.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    Key? key,
    this.hintText,
    this.enabled = true,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);
  final bool enabled;
  final bool isPassword;
  final int minLines;
  final int maxLines;
  final String? hintText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool isShow = false;
  @override
  void initState() {
    isShow = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      style: contentRegular,
      obscureText: isShow,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      onTap: widget.onTap ?? () {},
      onChanged: widget.onChanged ?? (v) => setState(() => {}),
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                child: Icon(
                  isShow
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: primaryWater,
                ),
              )
            : const SizedBox.shrink(),
        errorMaxLines: 4,
        hintText: widget.hintText,
        hintStyle: contentRegular.copyWith(
          color: grayscaleCharcoalLightest,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: grayscaleCharcoalLightest),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: grayscaleStone),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryWater),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
