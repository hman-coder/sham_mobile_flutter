import 'dart:async';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/repositories/activities_repository.dart';

class ActivitiesController extends GetxController {
  var _activities = <Activity>[].obs;

  ActivitiesRepository _repo = ActivitiesRepository();

  RefreshController refreshController = RefreshController(
    initialRefresh: false
  );

  List<Activity> get activities => _activities.toList();

  @override
  void onInit() {
    loadMoreActivities();
    super.onInit();
  }

  StreamSubscription listenToActivities(Function(List<Activity>)  listener) {
    return _activities.listen(listener);
  }

  void loadMoreActivities() async {
    _activities.addAll(await _repo.fetchActivities(_activities.length));
    refreshController.loadComplete();
  }

  void refreshActivities() async {
    _activities.clear();
    _activities.addAll(await _repo.fetchActivities());
    refreshController.refreshCompleted();
  }
}