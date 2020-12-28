import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/book/book_controller.dart';
import 'package:sham_mobile/book/view_book_ui.dart';
import 'package:sham_mobile/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  final Widget trailing;

  final Function() onTap;

  const BookTile({Key key, @required this.book, this.trailing, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      onTap: onTap ?? () => Get.to(GetBuilder(
        init: BookController(book),
        builder: (controller) => ViewBookUI()
      )
      ),
      subtitle: Text(book.authorsAsString),
      leading: Image.asset(book.image),
      trailing: trailing
    );
  }
}
