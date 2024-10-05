
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../widgets/app_widgets.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

var logger = Logger();
// var myWidget = myWidget;
// var appHelper = AppHelper();
// var apiClient = ApiClient();
var appWidget = AppWidgets();

double mainPaddingW = 20.0;
double mainPaddingH = 20.0;

EdgeInsetsGeometry mainPadding(
    double leftRight,
    double topBottom, {
      double? leftPadding,
      double? rightPadding,
      double? topPadding,
      double? bottomPadding,
    }) {
  return EdgeInsets.only(
    left: (leftPadding ?? leftRight),
    right: (rightPadding ?? leftRight),
    top: (topPadding ?? topBottom),
    bottom: (bottomPadding ?? topBottom),
  );
}


final Widget gapW3 = appWidget.gapW(3);
final Widget gapW6 = appWidget.gapW(6);
final Widget gapW8 = appWidget.gapW(8);
final Widget gapW12 = appWidget.gapW(12);
final Widget gapW16 = appWidget.gapW(16);
final Widget gapW18 = appWidget.gapW(18);
final Widget gapW20 = appWidget.gapW(20);
final Widget gapW24 = appWidget.gapW(24);
final Widget gapW30 = appWidget.gapW(30);
final Widget gapW34 = appWidget.gapW(34);

final Widget gapH3 = appWidget.gapH(3);
final Widget gapH6 = appWidget.gapH(6);
final Widget gapH8 = appWidget.gapH(8);
final Widget gapH12 = appWidget.gapH(12);
final Widget gapH16 = appWidget.gapH(16);
final Widget gapH18 = appWidget.gapH(18);
final Widget gapH20 = appWidget.gapH(20);
final Widget gapH24 = appWidget.gapH(24);
final Widget gapH30 = appWidget.gapH(30);
final Widget gapH32 = appWidget.gapH(32);
final Widget gapH48 = appWidget.gapH(48);
