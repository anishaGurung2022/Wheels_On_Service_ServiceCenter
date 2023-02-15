import 'package:flutter/material.dart';
import 'package:get/get.dart';

const primaryColor = Color(0xffF77931);
const backgroundColor = Colors.white;
const textColor = Colors.black;

showMessage(
    {required String title, required String message, isSuccess = true}) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    backgroundColor: isSuccess ? Colors.green : Colors.red,
  );
}

const lockIcon = Icon(Icons.lock);
