import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/book_lists/book_lists_controller.dart';
import 'package:sham_mobile/models/book_list.dart';
import 'package:sham_mobile/widgets/default_values.dart';

import 'book_list_tile.dart';

class BookListsPickerDialog extends GetView<BookListsController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('select_book_list'.tr),
      actions: [
        FlatButton(
          child: Text('cancel'.tr),
          onPressed: () => Get.back(),
        )
      ],
      content: SingleChildScrollView(
        child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              _AddBookListTile(),
              Divider(),
            ]..addAll(controller.bookLists.map((value) => BookListTile(
                onTap: () => Get.back(result: value),
                bookList: value))),
        ),
        ),
      )
    );
  }
}


class _AddBookListTile extends StatefulWidget {
  @override
  _AddBookListTileState createState() => _AddBookListTileState();
}

class _AddBookListTileState extends State<_AddBookListTile> {
  bool showField = false;

  String bookListName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: AnimatedSwitcher(
          duration: 500.milliseconds,
          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
          child: showField ? _buildField(context) : _buildTile(context)
      ),
    );
  }

  Widget _buildTile(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.add, color: Colors.green),
        title: Text('add_book_list'.tr, style: TextStyle(fontSize: DefaultValues.mediumTextSize)),
        onTap: () => setState(() => showField = !showField)
    );
  }

  Widget _buildField(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 120),
          child: TextField(
            onChanged: (text) => bookListName = text,
            decoration: InputDecoration(
              hintText: 'enter_book_list_name'.tr
            ),
          ),
        ),

        IconButton(
            onPressed: () async {
                bool added = await Get.find<BookListsController>()
                    .addBookList(BookList(name: bookListName));
                if(added) setState(() => showField = false);
            },
            icon: Icon(Icons.add, color: Colors.green,)),

        IconButton(
          onPressed: () => setState(() => showField = false),
          icon: Icon(Icons.close, color: Colors.red),
        )
      ]
    );
  }
}
