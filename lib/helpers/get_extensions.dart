import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension GetExtensions on GetInterface {
  TextDirection get direction =>
      Get.locale.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr;
}