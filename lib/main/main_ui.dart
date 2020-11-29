import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/main/main_controller.dart';
import 'package:sham_mobile/books/main/widget/books_ui.dart';
import 'package:sham_mobile/widgets/sham_custom_icons.dart';
import 'widget/activities_ui.dart';
import 'widget/book_clubs_ui.dart';
import 'widget/offers_ui.dart';

class MainUI extends GetView<MainController> {
  Widget build(BuildContext context) {
    return Directionality(
          textDirection: Get.direction,

          child: ChangeNotifierProvider<PageController>(
            create: (context) => PageController(),

            child: Consumer<PageController>(

              builder: (context, pageController, child) => Scaffold(
                body: PageView(
                  controller: pageController,
                  children: <Widget>[
                    BooksUI(key: Key("books_ui")),
                    BookClubsUI(key: PageStorageKey<String>("book_clubs_ui")),
                    ActivitiesUI(),
                    OffersUI()
                  ],
                ),

                bottomNavigationBar: Builder(
                  builder: (context) => BottomNavigationBar(
                    currentIndex: context.watch<PageController>()?.page?.floor() ?? 0,
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
            ),
          ),
        );
  }
}