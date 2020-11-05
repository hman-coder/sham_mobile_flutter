import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingController extends GetxController {
  static final String _introShownKey = 'intro_shown';

  final _quote = ''.obs;

  String get quote => _quote.value;

  final _author = ''.obs;

  String get author =>_author.value;

  @override
  void onInit() {
    super.onInit();
    _loadQuote();
    _checkIfIntroWasShown();
  }

  void _loadQuote() {
    _quote.value = 'أجمل ما في الماضي أنه قد مضى';
    _author.value = "أوسكار وايلد - صورة دوريان غراي";
  }

  void _checkIfIntroWasShown() async {
    await Future.delayed(Duration(seconds: 2));

    SharedPreferences.setMockInitialValues(new Map<String, dynamic>());
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool introShown = preferences.containsKey(_introShownKey);
    String nextRouteName = introShown
        ? '/main'
        : '/login';

    Get.toNamed(nextRouteName);
  }


}