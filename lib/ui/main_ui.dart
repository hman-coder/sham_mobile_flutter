import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/controllers/main_controller.dart';
import 'package:sham_mobile/ui/books_ui.dart';
import 'package:sham_mobile/widgets_functional/sham_custom_icons.dart';
import 'package:sham_mobile/ui_temp/activities_ui.dart';
import 'package:sham_mobile/ui_temp/book_clubs_ui.dart';
import 'package:sham_mobile/ui_temp/offers_ui.dart';

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
                  onTap: controller.switchToPage,
                  backgroundColor: Colors.black,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(backgroundColor: Colors.black, label: 'books'.tr, icon: Icon(ShamCustomIcons.book_stack)),
                    BottomNavigationBarItem(backgroundColor: Colors.black, label: 'clubs'.tr, icon: Icon(Icons.group)),
                    BottomNavigationBarItem(backgroundColor: Colors.black, label: 'activities'.tr, icon: Icon(Icons.event)),
                    BottomNavigationBarItem(backgroundColor: Colors.black, label: 'offers'.tr, icon: Icon(Icons.local_offer)),
                  ],
                ),
              ),
            ),
        );
  }
}