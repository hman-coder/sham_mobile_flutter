import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/main/main_controller.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/books/main/widget/books_ui.dart';
import 'package:sham_mobile/widgets/sham_custom_icons.dart';

import 'widget/activities_ui.dart';
import 'widget/book_clubs_ui.dart';
import 'widget/offers_ui.dart';

class MainUI extends GetView<MainController> {
  Widget build(BuildContext context) {
    return Directionality(
          textDirection: ShamLocalizations.of(context).getDirection(),

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
                      BottomNavigationBarItem(backgroundColor: Colors.black, label: ShamLocalizations.getString(context, 'books'), icon: Icon(ShamCustomIcons.book_stack)),
                      BottomNavigationBarItem(backgroundColor: Colors.black, label: ShamLocalizations.getString(context, 'clubs'), icon: Icon(Icons.group)),
                      BottomNavigationBarItem(backgroundColor: Colors.black, label: ShamLocalizations.getString(context, 'activities'), icon: Icon(Icons.event)),
                      BottomNavigationBarItem(backgroundColor: Colors.black, label: ShamLocalizations.getString(context, 'offers'), icon: Icon(Icons.local_offer)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}