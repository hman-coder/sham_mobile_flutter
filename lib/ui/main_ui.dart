import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/controllers/main_controller.dart';
import 'package:sham_mobile/ui/books/books_ui.dart';
import 'package:sham_mobile/constants/sham_custom_icons.dart';
import 'package:sham_mobile/ui/activities_ui.dart';
import 'package:sham_mobile/ui/book_clubs_ui.dart';
import 'package:sham_mobile/ui/offers_ui.dart';

class MainUI extends GetView<MainController> {
  Widget build(BuildContext context) {
    return Directionality(
          textDirection: Get.direction,

          child: Scaffold(
              body: PageView(
                controller: controller.pageController,
                children: <Widget>[
                   BooksUI(),
                  BookClubsUI(key: PageStorageKey<String>("book_clubs_ui")),
                  ActivitiesUI(),
                  OffersUI()
                ],
              ),

              bottomNavigationBar: Obx(() =>
                BottomNavigationBar(
                  currentIndex: controller.currentIndex,
                  onTap: (index) {
                    SystemSound.play(SystemSoundType.click);
                    controller.switchToPageIndex(index);
                  },
                  backgroundColor: Colors.black,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(backgroundColor: Colors.black, label: 'books'.tr, icon: Icon(ShamCustomIcons.book_stack)),
                    BottomNavigationBarItem(backgroundColor: Colors.black, label: 'clubs'.tr, icon: Icon(ShamCustomIcons.book_club)),
                    BottomNavigationBarItem(backgroundColor: Colors.black, label: 'activities'.tr, icon: Icon(ShamCustomIcons.activity)),
                    BottomNavigationBarItem(backgroundColor: Colors.black, label: 'offers'.tr, icon: Icon(ShamCustomIcons.offer)),
                  ],
                ),
              ),
            ),
        );
  }
}