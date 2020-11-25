import 'dart:ui';

import 'package:flutter/material.dart';
import 'error_widgets.dart';
import 'package:get/get.dart';

class ErrorController extends GetxController {
  showError(ShamError error) {
    switch(error.displayType) {
      case ErrorDisplayType.snackbar:
        Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          titleText: error.header == null ? null : ErrorHeaderTextWidget(error.header) ,
          messageText: ErrorMessageTextWidget(error.message),
        );
        break;

      case ErrorDisplayType.dialog:
        Get.defaultDialog(
            title: error.header,
            content: Center(
                child: Text(error.message)
            ),
            backgroundColor: _mapSeverityToColor(error.severity).withOpacity(0.8),
        );
        break;
      case ErrorDisplayType.toast:
        break;
  };
  }

  Color _mapSeverityToColor(ErrorSeverity severity) {
    switch(severity) {
      case ErrorSeverity.severe:
        return Colors.red;

      case ErrorSeverity.moderate:
        return Colors.amber;

      case ErrorSeverity.mild:
        return Colors.black;
    }

    return null;
  }

  showUnknownError() {
    Get.rawSnackbar(
          messageText: ErrorMessageTextWidget('error_unknown_description'.tr),
          titleText: ErrorHeaderTextWidget('error_unknown'.tr),
          snackPosition: SnackPosition.BOTTOM,
          duration: 5.seconds,
          mainButton: FlatButton(onPressed: () => print('report'), child: Text('report'.tr)),
          isDismissible: true,
        );
  }
}

class ShamError {
  final ErrorSeverity severity;

  final ErrorDisplayType displayType;

  final String message;

  final String header;

  ShamError({
    @required this.severity,
    @required this.displayType,
    @required this.message,
    this.header});
}

enum ErrorSeverity {
  severe, moderate, mild,
}

enum ErrorDisplayType {
  snackbar, dialog, toast
}