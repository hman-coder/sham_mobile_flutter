import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/repositories/book_clubs_repository.dart';

class BookClubsController extends GetxController {
  var _bookClubsObs = <Activity>[].obs;

  var _repository = BookClubsRepository();

  RefreshController refreshController = RefreshController(initialRefresh: true);

  List<Activity> get bookClubs => _bookClubsObs.toList();

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