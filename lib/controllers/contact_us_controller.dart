import 'dart:math';

import 'package:get/get.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/models/contact_message.dart';

class ContactUsController extends GetxController {
  var _message = ContactMessage(
    subject: 'select_message_subject'.tr,
  ).obs;

  final List<String> subjects = [
    'select_message_subject'.tr,
    'report_an_error'.tr,
    'ask_a_question'.tr,
    'suggestion'.tr,
    'others_please_specify'.tr,
  ];

  var _sendingMessage = false.obs;

  bool get isSendingMessage => _sendingMessage.value;

  String get content => _message.value.content;

  String get subject => _message.value.subject;

  bool get toApp => _message.value.toApp;

  bool get toLibrary => _message.value.toLibrary;

  set subject(String subject) =>
      _message.update((val) => val.subject = subject);

  set content(String content) =>
      _message.update((val) => val.content = content);

  set toApp(bool value) => _message.update((val) => val.toApp = value);

  set toLibrary(bool toLibrary) =>
      _message.update((val) => val.toLibrary = toLibrary);

  final int messageContentMinLetters = 20;

  final int messageContentMaxLetters = 400;

  void sendMessage() async {
    String message;
    bool messageIsSent = false;

    if (!toApp && !toLibrary)
      message = 'specify_recipient'.tr;

    else if (subject == subjects[0] || subject.isEmpty)
      message = 'specify_subject'.tr;

    else if (content.length < messageContentMinLetters ||
        content.length > messageContentMaxLetters)
      message =
          " ${'message_range_from'.tr} $messageContentMinLetters ${'message_range_to'.tr} $messageContentMaxLetters";

    else {
      _sendingMessage.value = true;
      messageIsSent = await _sendMessage();
      message = messageIsSent
          ? 'message_sent_successfully'.tr
          : 'error_sending_message'.tr;
    }

    _sendingMessage.value = false;
    if(messageIsSent) Get.back();

    Get.find<ShamMessageController>().showMessage(ShamMessage(
        message: message,
        severity: MessageSeverity.mild,
        displayType: MessageDisplayType.snackbar));
  }

  Future<bool> _sendMessage() async {
    await Future.delayed(1.5.seconds);

    bool mockUpSuccess = Random().nextInt(10) > 3;

    return mockUpSuccess;
  }
}
