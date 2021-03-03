import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/widgets_ui/book_tile.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';
import 'package:sham_mobile/widgets_ui/loading_footer.dart';
import 'package:sham_mobile/widgets_ui/menu_floating_action_button.dart';
import 'package:sham_mobile/widgets_functional/sham_custom_icons.dart';
import 'package:sham_mobile/controllers/books_controller.dart';

import 'drawer_ui.dart';

class BooksUI extends StatefulWidget {

  BooksUI({Key key}) : super(key: key);

  @override
  _BooksUIState createState() => _BooksUIState();
}

class _BooksUIState extends State<BooksUI> with SingleTickerProviderStateMixin {
  BooksController booksController = Get.find<BooksController>();

  AnimationController menuFabController;

  final Duration animationDuration =  Duration(milliseconds: 600);

  @override
  void initState() {
    menuFabController = AnimationController(
      vsync: this,
      duration: animationDuration
    );

    super.initState();
  }

  @override
  void dispose() {
    menuFabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

        drawer: DrawerUI(),

        appBar: AppBar(
          title: Center(
              child: Text('books'.tr,)
          ),

          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: booksController.goToSearch,
            ),

            IconButton(
              icon: Icon(Icons.sort),
              onPressed: booksController.goToFilters,
            )
          ],
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

        floatingActionButton: _buildFab(),

        body: Obx(() => booksController.books.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SmartRefresher(
              controller: booksController.refreshController,
              onLoading: booksController.loadMoreBooks,
              onRefresh: booksController.refreshBooks,
              enablePullUp: true,
              footer: LoadingFooter(),
              child: ListView.builder(
                key: PageStorageKey("books_ui_list"),
                itemBuilder: (context, index) {
                  Book book = booksController.books[index];
                  return BookTile(
                    book: book,
                    trailing: _BookTileTrailingIcon(book: book)
                  );
                },
                itemCount: booksController.books.length,
              ),
            ),
        ),
    );
  }

  Widget _buildFab() {
    return MenuFloatingActionButton(
      mainButton: _buildMainFabButton(),
      animationController: menuFabController,
      fromDegree: 190,
      toDegree: 260,
      curve: Curves.easeInOutBack,
      duration: Duration(milliseconds: 500),

      menuItems: [
        _buildBlindDateButton(),

        _buildBookListsButton()
      ],
    );
  }

  Widget _buildMainFabButton() {
    return Container(
      width: 60,
      height: 60,
      child: Icon(Icons.menu, color: Colors.white),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: DefaultValues.maroon,
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.6),
                offset: Offset(3, 3)
            )
          ]
      ),
    );
  }

  Widget _buildBlindDateButton() {
    return FloatingActionButton(
      heroTag: 'blind_dates_fab',
      onPressed: () async {
        await menuFabController.reverse();
        booksController.goToBlindDates();
      },
      child: Icon(ShamCustomIcons.blind_date, color: Colors.white, size: 30),
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget _buildBookListsButton() {
    return FloatingActionButton(
      heroTag: 'book_lists_fab',
      onPressed: () async {
        await menuFabController.reverse();
        booksController.goToBookLists();
      },
      child: Icon(Icons.book, color: Colors.white, size: 30),
      backgroundColor: Colors.blueAccent,
    );
  }
}

class _BookTileTrailingIcon extends StatefulWidget {
  final Book book;

  const _BookTileTrailingIcon({Key key, @required this.book}) : super(key: key);

  @override
  _BookTileTrailingIconState createState() => _BookTileTrailingIconState();
}

class _BookTileTrailingIconState extends State<_BookTileTrailingIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPress,
        icon: Icon(
          widget.book.addedToLibrary ? Icons.playlist_add_check : Icons.playlist_add,
          color: widget.book.addedToLibrary ? Colors.blue : Colors.grey,
          key: ValueKey('${widget.book.title}-${widget.book.addedToLibrary}'),
        )
    );
  }

  void onPress() async {
    await Get.find<BooksController>()
        .addBookToBookList(widget.book);
    setState(() {});
  }
}
