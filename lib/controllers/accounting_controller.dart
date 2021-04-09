import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/sham_controller.dart';
import 'package:sham_mobile/controllers/user_controller.dart';
import 'package:sham_mobile/models/purchase_record.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/repositories/accounting_repository.dart';

class AccountingController extends ShamController {
  var _obsPurchaseRecords = <PurchaseRecord>[].obs;

  var _obsAllItemsAreLoaded = false.obs;

  final RefreshController refreshController = RefreshController();

  final AccountingRepository _repository = AccountingRepository();

  List<PurchaseRecord> get purchaseRecords => _obsPurchaseRecords.toList();

  bool get allItemsAreLoaded => _obsAllItemsAreLoaded.value;

  AccountingController() : super(initialLoading: true);

  @override
  void onReady() async {
    await loadMorePurchaseRecords();
    finishLoading();
    super.onReady();
  }

  /// A counter used to limit the amount of data a user can retrieve
  int _mockCounter = 0;

  loadMorePurchaseRecords() async {
    // Mock
    if(_mockCounter > 3) return;

    int userId = Get.find<UserController>().user.id;
    List<PurchaseRecord> records = await _repository.fetchPurchaseRecords(userId);
    _obsPurchaseRecords.addAll(records);
    refreshController.loadComplete();

    // Mock
    if(++_mockCounter > 3) _obsAllItemsAreLoaded.value = true;
  }

  refreshPurchaseRecords() async {
    int userId = Get.find<UserController>().user.id;
    List<PurchaseRecord> records = await _repository.fetchPurchaseRecords(userId);
    _obsPurchaseRecords.clear();
    _obsPurchaseRecords.addAll(records);

    refreshController.refreshCompleted();

    // Mock
    _obsAllItemsAreLoaded.value = false;
    _mockCounter = 0;
  }
}