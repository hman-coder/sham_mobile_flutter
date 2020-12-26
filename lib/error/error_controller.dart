import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'error_widgets.dart';
import 'package:get/get.dart';

class ShamErrorController extends GetxController {
  showMessage(ShamMessage error) {
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

  Future<bool> showConfirmation
      ({@required String title, @required String message}) async {
    assert(title != null && message != null, 'You must provide both title and message');
    return await Get.dialog<bool>(
      ConfirmationDialog(title: title, message: message)
    );
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
          mainButton: FlatButton(
              onPressed: () => print('report'),
              child: Text('report'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: DefaultValues.mediumTextSize,
                  fontWeight: FontWeight.bold
                ),
              )
          ),
          isDismissible: true,
        );
  }
}

class ShamMessage {
  final ErrorSeverity severity;

  final ErrorDisplayType displayType;

  final String message;

  final String header;

  ShamMessage({
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