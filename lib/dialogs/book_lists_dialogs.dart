import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/book_lists_controller.dart';
import 'package:sham_mobile/widgets_ui/default_values.dart';

import 'package:sham_mobile/widgets_ui/book_list_tile.dart';

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
              _buildAddBookListTile(context),
              Divider(),
            ]..addAll(controller.bookLists.map((value) => BookListTile(
                onTap: () => Get.back(result: value),
                bookList: value))),
        ),
        ),
      )
    );
  }

  Widget _buildAddBookListTile(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.add, color: Colors.green),
        title: Text('add_book_list'.tr, style: TextStyle(fontSize: DefaultValues.mediumTextSize)),
        onTap: controller.addBookList
    );
  }
}

/// Returns null if the user pressed cancel, a (possibly
/// empty) String otherwise.

// ignore: must_be_immutable
class AddOrEditBookListDialog extends StatelessWidget {
  final String initialName;

  AddOrEditBookListDialog({Key key, this.initialName}) : super(key: key);

  String name = '';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('enter_book_list_name'.tr),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: TextEditingController(text: initialName),
            onChanged: (value) => name = value,
          ),
        ),

        FlatButton(onPressed: () => Get.back(result: name), child: Text('confirm'.tr)),
        FlatButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
      ],
    );
  }
}

