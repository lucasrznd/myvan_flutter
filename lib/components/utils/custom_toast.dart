import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static void showToast(BuildContext context, String message) {
    DelightToastBar(
      builder: (context) {
        return ToastCard(
          leading: const Icon(
            Icons.person,
            size: 32,
          ),
          title: Text(
            message,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      snackbarDuration: Durations.extralong4 * 3,
    ).show(context);
  }

  static void errorToast(BuildContext context, String message) {
    DelightToastBar(
      builder: (context) {
        return ToastCard(
          leading: const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 32,
          ),
          title: Text(
            message,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      snackbarDuration: Durations.extralong4 * 3,
    ).show(context);
  }
}
