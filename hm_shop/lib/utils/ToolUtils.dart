import 'package:flutter/material.dart';

class ToolUtils {
  static bool showLoading = false;
  static void showToast(BuildContext context, String? msg) {
    if (showLoading) {
      return;
    }
    showLoading = true;
    Future.delayed(Duration(seconds: 2), () {
      showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(msg ?? "加载中", textAlign: TextAlign.center),
      ),
    );
  }
}
