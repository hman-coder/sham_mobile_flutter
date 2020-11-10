
import 'package:get/get.dart';
import 'package:sham_mobile/main/widget/main_ui.dart';
import 'package:sham_mobile/user/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingController extends GetxController {
  static final String _logTag = "LoadingController";

  static final String _introShownKey = 'intro_shown';

  // final _quote = ''.obs;
  //
  // get quote => _quote;
  //
  // final _author = ''.obs;
  //
  // get author =>_author;

  @override
  void onInit() async {
    super.onInit();
    if(await _initializeSharedPreferences()) {
      _setupUserController();
      Get.to(MainUI());
    }
  }

  // void _loadQuote() {
  //   log('Loading arabic quotes', name: _logTag);
  //   _quote.value = 'أجمل ما في الماضي أنه قد مضى';
  //   _author.value = "أوسكار وايلد - صورة دوريان غراي";
  // }
  //
  // void _updateQuote() async {
  //   await Future.delayed(2.seconds);
  //   log('Loading english quotes', name: _logTag);
  //   _quote.value = 'The most beautiful thing about the past is that it\'s past';
  //   _author.value = 'Oscar Wild - The Picture of Dorian Grey';
  // }

  Future<bool> _initializeSharedPreferences() async {
    await Future.delayed(2.seconds);
    // TODO: Load SharedPreferences.
    // TODO: Check for a list of quotes
    // TODO: if not found check for connection
    // TODO: if no connection, show error (don't start app)
    // TODO: else fetch the quotes from the internet
    // TODO: load quote
    SharedPreferences.setMockInitialValues(new Map<String, dynamic>());
    return true;
  }

  void _setupUserController() {
    Get.put(UserController(), permanent: true);
  }
}