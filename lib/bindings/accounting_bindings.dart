import 'package:get/get.dart';
import 'package:sham_mobile/controllers/accounting_controller.dart';

class AccountingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountingController());
  }

}