import 'package:flutter/material.dart';
import 'package:sham_mobile/models/book_list.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/widgets/default_values.dart';

class BookListTile extends StatelessWidget {
  final BookList bookList;

  final Function() onTap;

  const BookListTile({Key key, @required this.bookList, @required this.onTap}) :
        assert(bookList != null && onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(bookList.name, style: TextStyle(fontSize: DefaultValues.mediumTextSize)),
      subtitle: Text( '${'contains'.tr} ${bookList.books.length} ${'elements'.tr}'),
      onTap: onTap,
    );
  }
}
