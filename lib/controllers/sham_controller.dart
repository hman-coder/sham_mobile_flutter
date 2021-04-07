import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/message_controller.dart';

abstract class ShamController extends GetxController {
  bool get isLoading => _isLoading.value;

  @protected
  void finishLoading() => _isLoading.value = false;

  @protected
  void startLoading() => _isLoading.value = true;

  var _isLoading;

  ShamController({bool initialLoading = false}) : _isLoading = initialLoading.obs;

  @protected
  ShamMessageController get messageController => Get.find<ShamMessageController>();
}