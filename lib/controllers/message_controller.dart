import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/controllers/sham_controller.dart';
import 'package:sham_mobile/ui/widgets/error_widgets.dart';
import 'package:get/get.dart';

class ShamMessageController extends ShamController {
  showMessage(ShamMessage error) {
    switch(error.displayType) {
      case MessageDisplayType.snackbar:
        Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          titleText: error.header == null ? null : ErrorHeaderTextWidget(error.header) ,
          messageText: ErrorMessageTextWidget(error.message),
        );
        break;

      case MessageDisplayType.dialog:
        Get.defaultDialog(
            title: error.header,
            content: Center(
                child: Text(error.message)
            ),
            backgroundColor: _mapSeverityToColor(error.severity).withOpacity(0.8),
        );
        break;
      case MessageDisplayType.toast:
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

  Color _mapSeverityToColor(MessageSeverity severity) {
    switch(severity) {
      case MessageSeverity.severe:
        return Colors.red;

      case MessageSeverity.moderate:
        return Colors.amber;

      case MessageSeverity.mild:
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
                  fontSize: ktsMediumTextSize,
                  fontWeight: FontWeight.bold
                ),
              )
          ),
          isDismissible: true,
        );
  }
}

class ShamMessage {
  final MessageSeverity severity;

  final MessageDisplayType displayType;

  final String message;

  final String header;

  ShamMessage({
    @required this.severity,
    @required this.displayType,
    @required this.message,
    this.header});
}

enum MessageSeverity {
  severe, moderate, mild,
}

enum MessageDisplayType {
  snackbar, dialog, toast
}