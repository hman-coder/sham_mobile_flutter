import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/sham_controller.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/repositories/book_clubs_repository.dart';

class BookClubsController extends ShamController {
  var _bookClubsObs = <Activity>[].obs;

  var _repository = BookClubsRepository();

  RefreshController refreshController = RefreshController();

  List<Activity> get bookClubs => _bookClubsObs.toList();


  @override
  void onReady() {
    loadMoreClubs();
    super.onReady();
  }

  Future loadMoreClubs() async {
    await Future.delayed(3.seconds);
    _bookClubsObs.addAll(_repository.bookClubs);
    refreshController.loadComplete();
  }

  void refreshClubs() async {
    await Future.delayed(3.seconds);
    _bookClubsObs.clear();
    _bookClubsObs.addAll(_repository.bookClubs);

    refreshController.refreshCompleted();
  }
}