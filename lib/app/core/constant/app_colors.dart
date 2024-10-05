import 'package:flutter/material.dart';

class AppColor {
  static const int _primaryColorValue = 0xFF228BC8;
  static const MaterialColor colorPrimarySwatch = MaterialColor(
    _primaryColorValue,
    <int, Color>{
      50: Color(0xFFE9F3FA),
      100: Color(0xFFBADBEE),
      200: Color(0xFF99CAE6),
      300: Color(0xFF6BB1DA),
      400: Color(0xFF4EA2D3),
      500: Color(_primaryColorValue),
      600: Color(0xFF1F7EB6),
      700: Color(0xFF18638E),
      800: Color(0xFF134C6E),
      900: Color(0xFF0E3A54),
    },
  );

  static const backgroundColor = Color(0xFFFFFFFF);
  static const bannerColor = Color(0xFFFFE5E5);

  // static const primaryColor = Color(0xFF693392);
  static const secondaryColor = Color(0xFF5ACDFF);
  static const secondaryColor2 = Color(0xFFD8EEFF);
  static const purpleColor = Color(0xFF9B4D9D);
  static const transparent = Color(0x00bd4efe);
  static const booksDetailsBackground = Color(0xffEFF4F9);
  static const appDefaultBackground = Color(0xffF4F5FC);
  static const richTextColor = Color(0xff33B9C0);
  static const comicBackgroundColor = Color(0xFFD1D5DB);
  static const textGrey = Color(0xff878787);
  static const hintTextGrey = Color(0xff6c6c6c);
  static const yogurtColor = Color(0xffFAD9D9);

  //aurnab
  static const darkPurple = Color(0xFF12101F);
  static const purple = Color(0xFF5C3BFF);
  static const dotIndicatorColor = Color(0xFF0042E0);
  static const black = Color(0xFF091C32);
  static const blackPure = Color(0xFF000000);
  static const micBackgroundColor = Color(0xffF2F2F2);
  static const iconColor = Color(0xff222222);
  static const white = Color(0xFFFFFFFF);
  static const gray = Color(0xFF52596E);
  static const liteGray = Color(0xFFD9D9D9);
  static const liteGrayStepLine = Color(0xFF8FAABB);
  static const liteStepLine = Color(0xFFE2F0FD);
  static const inputColor = Color(0x8052596E); //alpha 50%
  static const wrong = Color(0xFFC20707);
  static const green = Color(0xFF34A853);
  static const borderGreen = Color(0xFF318147);
  static const enrollBackground = Color(0xFF08BD80);
  static const liteGreen = Color(0xFF56C674);
  static const red = Color(0xFFFF1F00);
  static const darkRed = Color(0xFF4A154B);
  static const drawerBackground = Color(0xffb0d2ac);
  static const orangeLite = Color(0xFFFE914E);
  static const orangeDeep = Color(0xFFd18513);
  static const activeSwitch = Color(0xFF08ABB3);
  static const chatBackground = Color(0xFF4C964B);
  static const appBarBackground = Color(0xFF4F177A);

  static const headerTextColor = Color(0xFF172B4D);
  static const appBarTextColor = Color(0xFF000000);
  static const underlineColor = Color(0xFFCCCCCC);
  static const textColorBlue = Color(0xFF2E38B6);
  static const fieldColor = Color(0xFF846AE3);

  //text field
  static const textFieldBorderColor = Color(0xFFE8E8E8);
  static const simpleTextColor = Color(0xFF484848);
  static const liteGrey = Color(0xFFF6F4F5);
  static const bgColor = Color(0xFFF7F8FA);
  static const bg2Color = Color(0xFFF5F2FA);



  /// [pie chart] color
  static const problemSolvingColor = Color(0xff9779FF);
  static const primaryColor = Color(0xff7B60FF);
  static const cardBackgroundColor2 = Color(0xffE9F3FA);
  static const communicationSkillsColor = Color(0xff5C3BFF);

  static const shimmerBaseColor = Color(0xFFD9D9D9);
  static const shimmerHighlightColor = Color(0xFFF6F6F6);

  static const buttonBlack = Color(0xff353237);
  static const likeWhite = Color(0xffEEEEEE);
  static const grey = Color(0xFF52596E);
  static const lightGrey = Color(0xFFA3A3AB);
  static const hintTextColor = Color(0xFF757575);

  static const infoColor = Color(0xFF33b5e5);
  static const successColor = Color(0xFF00C851);
  static const errorColor = Color(0xFFff4444);

  static const borderGrayColor = Color(0xFFBCBCBC);
  static const cardBackgroundColor = Color(0xFFFFFFFF);
  static const shadowColor = Color(0xFFBCBCBC);

  static const disableColor = Color(0xFFEEEEEE);

  static const gradientLeftColor = secondaryColor2;
  static const gradientRightColor = Color(0xFFFFFFFF);

  static const goldenPurpleColor = Color(0xffEFDBFF);
  static const baseGradient = LinearGradient(
    colors: [
      communicationSkillsColor,
      primaryColor,
      problemSolvingColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const drawerBackgroundGradientLeftColor = secondaryColor2;
  static const drawerBackgroundGradientRightColor = Color(0xFFFFFFFF);

  static const drawerBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColor.drawerBackgroundGradientLeftColor,
      AppColor.drawerBackgroundGradientRightColor,
    ],
    stops: [0.3, 0.8],
  );

  static const Color editTextBorderColor = Color(0xFFE6E6E6);
  static const Color editTextBGColor = Color(0xFFFBFCFE);
  static const Color dropdownEditTextBGColor = Color(0xFFF6FFFC);
}
