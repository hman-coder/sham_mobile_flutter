import 'package:get/get.dart';
import 'english.dart';
import 'arabic.dart';

class ShamTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': englishTranslations,
    'ar': arabicTranslations
  };
}