import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/book_lists_controller.dart';
import 'package:sham_mobile/ui/widgets/tiles/book_list_tile.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';

class BookListsUI extends StatelessWidget {
  final BookListsController controller = Get.find<BookListsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('book_lists'.tr)),

      floatingActionButtonLocation: Get.direction == TextDirection.rtl
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.addBookList
      ),

      body: Obx(() => ListView.separated(
          itemCount: controller.bookLists.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index)  {
            var bookList = controller.bookLists[index];
            return BookListTile(
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => controller.editBookList(bookList),
              ),

              leading: IconButton(
                onPressed: () => controller.removeBookList(bookList),
                icon: Icon(Icons.remove_circle_outline, color: Colors.red,),
              ),
              onTap: () => controller.onBookListPressed(bookList),
              bookList: bookList,
            );
          }
        ),
      ),
    );
  }
}