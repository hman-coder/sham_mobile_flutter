import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/ui/widgets/tiles/book_tile.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/ui/widgets/loading_footer.dart';
import 'package:sham_mobile/controllers/single_book_list_controller.dart';

class SingleBookListUI extends StatefulWidget {

  SingleBookListUI({Key key}) : super(key: key);

  @override
  _SingleBookListUIState createState() => _SingleBookListUIState();
}

class _SingleBookListUIState extends State<SingleBookListUI> {
  final SingleBookListController controller = Get.find<SingleBookListController>();

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
                  style: TextStyle(fontSize: ktsLargeTextSize),
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