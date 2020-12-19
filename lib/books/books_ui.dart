import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/book_lists/book_lists_controller.dart';
import 'package:sham_mobile/book_lists/book_lists_dialog.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/book_list.dart';
import 'package:sham_mobile/user/user_controller.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/loading_footer.dart';
import 'package:sham_mobile/widgets/menu_floating_action_button.dart';
import 'package:sham_mobile/widgets/sham_custom_icons.dart';

import 'books_controller.dart';

/// There is a small bug in using getx with pull_to_refresh
/// If you want to use a ListView in wrapped in an Obx widget
/// as a child of SmartRefresher, loading and pull-to-refresh
/// functions will not work.
/// This is because pull_to_refresh treats Widgets differently than
/// Slivers (or SliverLists), and Obx is a widget.
///
/// To avoid the issue, a StatefulWidget has been used instead
/// of a GetView<BooksController>
class BooksUI extends StatefulWidget {
  @override
  _BooksUIState createState() => _BooksUIState();
}

class _BooksUIState extends State<BooksUI> with SingleTickerProviderStateMixin{
  BooksController booksController = Get.find<BooksController>();
  bool closeFabMenu = false;

  AnimationController menuFabController;

  @override
  void initState() {
    menuFabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600)
    );

    // To avoid using Obx (see class documentation for reasoning),
    // a listener to the book list in the controller is added:
    booksController.addListenerToBooks((books) => setState((){}));

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

        appBar: AppBar(
            title: Center(
                child: Text('books'.tr,
                  style: TextStyle(fontSize: DefaultValues.largeTextSize),
                )
            )
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

        floatingActionButton: MenuFloatingActionButton(
          animationController: menuFabController,
          fromDegree: 190,
          toDegree: 260,
          curve: Curves.easeInOutBack,
          duration: Duration(milliseconds: 700),
          menuItems: [
            FloatingActionButton(
              onPressed: menuFabController.reverse,
              child: Icon(ShamCustomIcons.blind_date, color: Colors.white, size: 30),
              backgroundColor: Colors.blue,
            ),

            FloatingActionButton(
              onPressed: menuFabController.reverse,
              child: Icon(Icons.book, color: Colors.white, size: 30),
              backgroundColor: Colors.amber,
            )
          ],

          fab: FloatingActionButton(),
      ),

      body: SmartRefresher(
        controller: booksController.refreshController,
        onLoading: booksController.loadMoreBooks,
        onRefresh: booksController.refreshBooks,
        enablePullUp: true,
        footer: LoadingFooter(),
        child: ListView.builder(
              itemBuilder: (context, index) =>
                  _MainBookItem(booksController.books[index]),
              itemCount: booksController.books.length,
            ),
      )
    );
  }
}


class _MainBookItem extends StatefulWidget {
  final Book book;

  const _MainBookItem(this.book, {Key key}) : super(key: key);

  @override
  __MainBookItemState createState() => __MainBookItemState();
}

class __MainBookItemState extends State<_MainBookItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.book.title),
        subtitle: Text(widget.book.authorsAsString),
        leading: Image.asset(widget.book.image),
        trailing: IconButton(
            onPressed: onPress,
            icon: AnimatedSwitcher(
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              duration: Duration(milliseconds: 400),
              child: Icon(
                widget.book.addedToLibrary ? Icons.playlist_add_check : Icons.playlist_add,
                color: widget.book.addedToLibrary ? Colors.blue : Colors.grey,
                key: ValueKey('${widget.book.title}-${widget.book.addedToLibrary}'),
              ),
            )
        ),
    );
  }

  void onPress() async {
    await Get.find<BooksController>()
        .addBookToBookList(widget.book);
    setState(() {});
  }
}

class _BlindDateItem extends StatefulWidget {
  final Book blindDate;

  const _BlindDateItem({Key key, this.blindDate}) : super(key: key);

  @override
  _BlindDateItemState createState() => _BlindDateItemState();
}

class _BlindDateItemState extends State<_BlindDateItem> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 75),
      child: Card(
          margin: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 40,
                child: SizedBox(
                  height: 200,
                  child: Container(
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),),
                        image: DecorationImage(
                            image: AssetImage(widget.blindDate.image),
                            fit: BoxFit.fill
                        ),
                      )
                  ),),
              ),

              Expanded(
                flex: 60,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(child: Text(widget.blindDate.title)),
                ),
              )
            ],
          )
      ),
    );
  }
}