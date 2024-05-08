import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/cColors.dart';


class CTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final double? width;
  final TextStyle? hintstyle;
  final Widget? prefixIcon;
  final TextEditingController? textEditingController;
  final bool obsecureText;
  final InputDecoration? decoration;
  final Widget? suffixIcon;
  final TextInputType? KeyboardType;
  final void Function()?onTap;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final Color? fillcolor;
  final bool? isfilled;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? labelStyle;
  final Widget? label;
  final OutlineInputBorder? border;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final Widget? prefix;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final BorderSide? borderSide;
  final bool? readOnly;
  final  TextCapitalization? textCapitalization;

  const CTextFormField({
    Key? key,
    this.controller,
    this.textAlign,
    this.maxLines,
    this.isfilled = false,
    this.width,
    this.decoration,
    this.contentPadding,
    this.onTap,
    this.border,
    this.fillcolor,
    this.inputFormatters,
    this.textEditingController,
    this.KeyboardType,
    this.hintText,
    this.obsecureText = false,
    this.suffixIcon,
    this.hintstyle,
    this.labelStyle,
    this.prefixIcon,
    this.label,
    this.validator,
    this.borderRadius,
    this.prefix,
    this.enabledBorder,
    this.focusedBorder,
    this.borderSide,
    this.maxLength,
    this.readOnly,
    this.textCapitalization,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly == null ? false : true,
      cursorColor: cGrayColor,
      controller: controller,
      maxLines: maxLines ?? 1,
      textCapitalization:textCapitalization??TextCapitalization.none,
      obscureText: obsecureText,
      validator: validator,
      maxLength: maxLength,
      keyboardType: KeyboardType,
      textAlign: textAlign ?? TextAlign.start,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding:contentPadding?? EdgeInsets.only(top: 18, left: 10, right: 0, bottom: 18),
        suffixIcon: suffixIcon,
        fillColor: fillcolor ?? cGrayColor2,
        filled: true,
        hintText: hintText,
        label: label,
        labelStyle: labelStyle ?? TextStyle(color: cGrayColor),
        hintStyle: hintstyle ?? TextStyle(color: cGrayColor),
        prefixIcon: prefixIcon,
        
        prefix: prefix,
        alignLabelWithHint: true,
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
              borderSide:
                  borderSide ?? BorderSide(width: 1, color: cRedColor),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: cTextfeildBdrColor, width: 1),
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: cTextfeildBdrColor, width: 1),
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ),
      ),
    );
  }
}
