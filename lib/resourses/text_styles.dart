import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/cColors.dart';

class TextStyles {
  static getSubTital20(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
    }) {
    return getBaseStyle(
        fontSize ?? 20, fontWeight ?? FontWeight.w700, textColor ?? cPrimeryColor2,
         );
  }

  static getSubTital24(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      String? fontFamily}) {
    return getBaseStyle(
      
        fontSize ?? 24,
        fontWeight ?? FontWeight.w700,
        textColor ?? cBlackColor);
  }

  static getSubTita16(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      String? fontFamily}) {
    return getBaseStyle(
       
        fontSize ?? 16,
        fontWeight ?? FontWeight.w400,
        textColor ?? cGrayColor3);
  }
  static getSubTita15(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      String? fontFamily}) {
    return getBaseStyle(
       
        fontSize ?? 15,
        fontWeight ?? FontWeight.w400,
        textColor ?? cWhiteColor);
  }
  static getSubTita14(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      String? fontFamily}) {
    return getBaseStyle(
       
        fontSize ?? 14,
        fontWeight ?? FontWeight.w700,
        textColor ?? cGrayColor3);
  }
  static getSubTita12(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      String? fontFamily}) {
    return getBaseStyle(
       
        fontSize ?? 12,
        fontWeight ?? FontWeight.w400,
        textColor ?? cGrayColor3);
  }
   static getSubTita10(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      String? fontFamily}) {
    return getBaseStyle(
       
        fontSize ?? 10,
        fontWeight ?? FontWeight.w400,
        textColor ?? cGrayColor);
  }
   static getSubTita13(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
      String? fontFamily}) {
    return getBaseStyle(
       
        fontSize ?? 13,
        fontWeight ?? FontWeight.w400,
        textColor ?? cGrayColor);
  }
  static getHeadline28(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
     }) {
    return getBaseStyle(
       
        fontSize ?? 28,
        fontWeight ?? FontWeight.w600,
        textColor ?? cBlackColor);
  }
  static getHeadline36(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
     }) {
    return getBaseStyle(
       
        fontSize ?? 36,
        fontWeight ?? FontWeight.w700,
        textColor ?? cblueColor);
  }
  static getHeadline32(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? textColor,
     }) {
    return getBaseStyle(
        fontSize ?? 32,
        fontWeight ?? FontWeight.w600,
        textColor ?? cPrimeryColor2);
  }

  static TextStyle getBaseStyle(
      double fontSize, FontWeight fontWeight, Color color,
   ) {
    return GoogleFonts.dmSans( 
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
