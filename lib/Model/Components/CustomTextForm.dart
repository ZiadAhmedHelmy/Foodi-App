
import 'package:flutter/material.dart';
import 'package:providerapp/utils/AppColors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? icon;
  final Color? iconColor;
  final Color? borderColor;
  final double? height;
  final int? maxLine;
  final TextInputType? keyboardType; // New parameter for keyboard type
  final bool? readOnly;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  CustomTextField({
    required this.controller,
    required this.hintText,
    this.icon,
    this.iconColor,
    this.borderColor,
    this.validator,
    this.height,
    this.maxLine,
    this.keyboardType, this.readOnly, this.onTap, // Added keyboardType parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          onTap: onTap ?? (){},
          controller: controller,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: icon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 2,
                color: AppColor.lightGrey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 2,
                color: AppColor.lightGrey,
              ),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          validator: validator,
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}