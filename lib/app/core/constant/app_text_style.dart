import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

const myFont = GoogleFonts.inter;

final hintStyle = myFont(
  color: AppColor.inputColor,
  fontWeight: FontWeight.w400,
);

TextStyle text12Style({
  color = AppColor.black,
  double fontSize = 12,
  fontWeight = FontWeight.w400,
  isWeight600 = false,
  isWeight500 = false,
  bool isGrayColor = false,
  bool isWhiteColor = false,
  bool isPrimaryColor = false,
  double? letterSpacing,
  double? lineHeight,
}) {
  return myFont(
    fontSize: fontSize,
    letterSpacing: letterSpacing,
    color: isPrimaryColor
        ? AppColor.primaryColor
        : isWhiteColor
        ? AppColor.white
        : isGrayColor
        ? AppColor.grey
        : color,
    fontWeight: isWeight600
        ? FontWeight.w600
        : isWeight500
        ? FontWeight.w500
        : fontWeight,
    height: lineHeight,
  );
}

TextStyle text14Style({
  color = AppColor.black,
  double fontSize = 14,
  fontWeight = FontWeight.w400,
  isWeight600 = false,
  isWeight500 = false,
  bool isGrayColor = false,
  bool isWhiteColor = false,
  bool isPrimaryColor = false,
  double? letterSpacing,
  double? lineHeight,
}) {
  return myFont(
    fontSize:  fontSize,
    letterSpacing: letterSpacing,
    color: isPrimaryColor
        ? AppColor.primaryColor
        : isWhiteColor
        ? AppColor.white
        : isGrayColor
        ? AppColor.grey
        : color,
    fontWeight: isWeight600
        ? FontWeight.w600
        : isWeight500
        ? FontWeight.w500
        : fontWeight,
    height: lineHeight,
  );
}

TextStyle text16Style({
  color = AppColor.black,
  double fontSize = 16,
  fontWeight = FontWeight.w500,
  isWeight600 = false,
  isWeight400 = false,
  bool isGrayColor = false,
  bool isWhiteColor = false,
  bool isPrimaryColor = false,
  double? letterSpacing,
  double? lineHeight,
}) {
  return myFont(
    fontSize:  fontSize,
    letterSpacing: letterSpacing,
    color: isPrimaryColor
        ? AppColor.primaryColor
        : isWhiteColor
        ? AppColor.white
        : isGrayColor
        ? AppColor.grey
        : color,
    fontWeight: isWeight600
        ? FontWeight.w600
        : isWeight400
        ? FontWeight.w400
        : fontWeight,
    height: lineHeight,
  );
}

TextStyle text18Style({
  color = AppColor.black,
  double fontSize = 18,
  fontWeight = FontWeight.w600,
  isWeight400 = false,
  isWeight500 = false,
  bool isGrayColor = false,
  bool isWhiteColor = false,
  bool isPrimaryColor = false,
  double? letterSpacing,
  double? lineHeight,
}) {
  return myFont(
    fontSize: fontSize,
    letterSpacing: letterSpacing,
    color: isPrimaryColor
        ? AppColor.primaryColor
        : isWhiteColor
        ? AppColor.white
        : isGrayColor
        ? AppColor.grey
        : color,
    fontWeight: isWeight400
        ? FontWeight.w400
        : isWeight500
        ? FontWeight.w500
        : fontWeight,
    height: lineHeight,
  );
}

TextStyle text20Style({
  color = AppColor.black,
  double fontSize = 20,
  fontWeight = FontWeight.w800,
  isWeight400 = false,
  isWeight500 = false,
  isWeight600 = false,
  bool isGrayColor = false,
  bool isWhiteColor = false,
  bool isPrimaryColor = false,
  double? letterSpacing,
  double? lineHeight,
}) {
  return myFont(
    fontSize: fontSize,
    letterSpacing: letterSpacing,
    color: isPrimaryColor
        ? AppColor.primaryColor
        : isWhiteColor
        ? AppColor.white
        : isGrayColor
        ? AppColor.grey
        : color,
    fontWeight: isWeight400
        ? FontWeight.w400
        : isWeight500
        ? FontWeight.w500
        : isWeight600
        ? FontWeight.w600
        : fontWeight,
    height: lineHeight,
  );
}
