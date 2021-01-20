import 'package:get/get.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/repositories/book_clubs_repository.dart';

class BookClubsController extends GetxController {
  var _isLoading = false.obs;

  var _bookClubsObs = <Activity>[].obs;

  var _repository = BookClubsRepository();

  bool get isLoading => _isLoading.value;

  List<Activity> get bookClubs => _bookClubsObs.toList();

  @override
  void onInit() {
    Future.delayed(3.seconds).then((value) => this._bookClubsObs.addAll(_repository.bookClubs));
    super.onInit();
  }
}