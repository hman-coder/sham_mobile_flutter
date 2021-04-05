import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

abstract class ShamController extends GetxController {
  bool get isLoading => _isLoading.value;

  @protected
  set isLoading(bool value) => _isLoading.value = value;

  var _isLoading;

  ShamController({bool initialLoading = false}) : _isLoading = initialLoading.obs;

}