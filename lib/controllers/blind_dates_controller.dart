import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/repositories/blind_dates_repository.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/models/blind_date.dart';
import 'package:sham_mobile/controllers/user_controller.dart';

class BlindDatesController extends GetxController {
  final _obsBlindDates = <BlindDate>[].obs;

  List<BlindDate> get blindDates => _obsBlindDates.toList();

  final refreshController = RefreshController();

  final repository = BlindDatesRepository();

  @override
  void onReady() {
    loadMoreBlindDates();
    super.onReady();
  }

  void loadMoreBlindDates() async {
    await Future.delayed(1.5.seconds);
    _obsBlindDates.addAll(await repository.fetchBlindDates(startingIndex: blindDates.length - 1));

    refreshController.loadComplete();
  }

  void refreshBlindDates() async {
    await Future.delayed(2.seconds);
    _obsBlindDates.clear();
    _obsBlindDates.addAll(await repository.fetchBlindDates());

    refreshController.refreshCompleted();
  }

  void requestBlindDate(BlindDate blindDate) async {
    if(await Get.find<UserController>().eligibleForServices
    && await _confirmRequest()) {
      await Future.delayed(1.seconds);
      Get.find<ShamMessageController>().showMessage(ShamMessage(
        message: 'request_sent'.tr,
        severity: MessageSeverity.mild,
        displayType: MessageDisplayType.snackbar,
      ));
    }
  }

  Future<bool> _confirmRequest() async {
    return await Get.find<ShamMessageController>()
        .showConfirmation(
        title: 'confirm'.tr, message: 'confirm_book_request_message'.tr);
  }
}