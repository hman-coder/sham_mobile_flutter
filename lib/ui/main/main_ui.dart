import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/ui/books/books_ui.dart';
import 'package:sham_mobile/widgets/sham_custom_icons.dart';

import 'activities_ui.dart';
import 'book_clubs_ui.dart';
import 'offers_ui.dart';

class MainUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {

  @override
  Widget build(BuildContext context) {
    ShamLocalizations localization = ShamLocalizations.of(context);
    return Directionality(
      textDirection: localization.getDirection(),

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
                onTap: (index) => setState(() => Provider.of<PageController>(context, listen: false).jumpToPage(index)),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(backgroundColor: Colors.black, title: Text(localization.getValue('books')), icon: Icon(ShamCustomIcons.book_stack)),
                  BottomNavigationBarItem(backgroundColor: Colors.black, title: Text(localization.getValue('clubs')), icon: Icon(Icons.group)),
                  BottomNavigationBarItem(backgroundColor: Colors.black, title: Text(localization.getValue('activities')), icon: Icon(Icons.event)),
                  BottomNavigationBarItem(backgroundColor: Colors.black, title: Text(localization.getValue('offers')), icon: Icon(Icons.local_offer)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}