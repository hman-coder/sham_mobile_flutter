import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/book/view_book_ui.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/widgets/book_tile.dart';
import 'package:sham_mobile/widgets/default_values.dart';
import 'package:sham_mobile/widgets/loading_footer.dart';
import 'book_list_controller.dart';

class BookListBooksUI extends StatefulWidget {

  BookListBooksUI({Key key}) : super(key: key);

  @override
  _BookListBooksUIState createState() => _BookListBooksUIState();
}

class _BookListBooksUIState extends State<BookListBooksUI> {
  final BookListBooksController controller = Get.find<BookListBooksController>();

  @override
  void initState() {
    controller.addListenerToBooks((_) => setState((){}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
            title: Center(
                child: Text(controller.bookList.name,
                  style: TextStyle(fontSize: DefaultValues.largeTextSize),
                )
            )
        ),

        body: SmartRefresher(
          controller: controller.refreshController,
          onLoading: controller.loadMoreBooks,
          enablePullUp: controller.canLoadMore,
          enablePullDown: false,
          footer: LoadingFooter(),
          child: ListView.builder(
            itemBuilder: (context, index) {
              Book book = controller.books[index];
              return BookTile(
                book: book,
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: () => controller.removeBookFromList(book),
                ),
              );
            },
            itemCount: controller.books.length,
          ),
        )
    );
  }
}