import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showErrorMessage(int statusCode) {
  String msgToShow = "Abrupt Request/Connection Declined";
  if (statusCode >= 500) {
    msgToShow = "Server Error";
  }
  Fluttertoast.showToast(
      msg: msgToShow,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

void popUp(String msg, Color clr) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: clr,
      textColor: Colors.white,
      fontSize: 16.0);
}
