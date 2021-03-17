import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/activities_controller.dart';
import 'package:sham_mobile/controllers/book_clubs_controller.dart';
import 'package:sham_mobile/controllers/books_controller.dart';
import 'package:sham_mobile/controllers/offers_controller.dart';
import 'package:sham_mobile/controllers/user_controller.dart';

class MainController extends GetxController{
  final PageController pageController = PageController();

  var _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void switchToPageIndex(int index) {
    pageController.animateToPage(index, curve: Curves.easeOutCubic, duration: 500.milliseconds);
  }

  void switchToPageName(String name) {
    switch(name) {
      case 'books':
        switchToPageIndex(0);
        break;

      case 'book_clubs':
        switchToPageIndex(1);
        break;

      case 'activities':
        switchToPageIndex(2);
        break;

      case 'offers':
        switchToPageIndex(3);
        break;
    }
  }

  @override
  void onInit() {
    Get.lazyPut(() => BooksController(), fenix: true);
    Get.lazyPut(() => BookClubsController(), fenix: true);
    Get.lazyPut(() => ActivitiesController(), fenix: true);
    Get.lazyPut(() => OffersController(), fenix: true);

    pageController.addListener(() {
      double currentPage = pageController.page;
      if(currentPage > (currentIndex + 0.5))
        _currentIndex.value += 1;

      else if(currentPage < (currentIndex - 0.5))
        _currentIndex.value -= 1;
    });
    super.onInit();
  }


  @override
  void onReady() {
    super.onReady();
    if(_shouldShowLogin()) Get.toNamed('/login');

  }


  bool _shouldShowLogin() =>
    Get.find<UserController>().user?.id == null
        || Get.find<UserController>().user.id == 0;
}