import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/book_clubs_controller.dart';
import 'package:sham_mobile/controllers/books_controller.dart';
import 'package:sham_mobile/controllers/user_controller.dart';

class MainController extends GetxController{
  final PageController pageController = PageController();

  var _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void switchToPage(int index) {
    pageController.animateToPage(index, curve: Curves.easeOutCubic, duration: 500.milliseconds);
  }

  @override
  void onInit() {
    Get.put(BooksController(), permanent: true);
    Get.put(BookClubsController(), permanent: true);
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
    // if(_isFirstAppStart()) {
    //   print('first time');
    //   Get.toNamed('/login');
    // }
  }

  bool _isFirstAppStart() =>
    Get.find<UserController>().user?.id == null
        || Get.find<UserController>().user.id == 0;
}