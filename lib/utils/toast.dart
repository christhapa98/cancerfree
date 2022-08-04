import 'package:flutter/material.dart';

toast(String msg, BuildContext context, {bool taskSuccess = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
      ),
      backgroundColor: taskSuccess == true ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
