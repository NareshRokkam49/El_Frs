import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/cColors.dart';

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

vGap(double height) {
  return SizedBox(
    height: height,
  );
}

hGap(double width) {
  return SizedBox(width: width);
}

void showSuccessMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
        child: Text(
      message,
      style: TextStyle(color: cGreenColor),
    )),
    backgroundColor: cLightGreenColor,
  ));
}

void showErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(message, style: TextStyle(color: cRedColor))),
    backgroundColor: cLightRedColor2,
  ));
}
void showServerMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(message, style: TextStyle(color: cBlackColor))),
    backgroundColor: cPrimeryColor2,
  ));
}
void showMessage(BuildContext context, String message) {

  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.red,
        fontSize: 16.0
    );
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(message, style: TextStyle(color: cBlackColor))),
    backgroundColor: cPrimeryColor2,
  ));
}
loadingText() {
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: cPrimeryColor2,
        ),
      ),
      hGap(10),
      Text(
        "Loading...",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      )
    ],
  );
}

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
bool isTab(BuildContext context) =>
    MediaQuery.of(context).size.width < 1300 &&
    MediaQuery.of(context).size.width >= 600;
bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 1300;
