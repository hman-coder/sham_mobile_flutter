import 'package:flutter/material.dart';
import 'package:sham_mobile/models/book_list.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/constants/default_values.dart';

class BookListTile extends StatelessWidget {
  final BookList bookList;

  final Function() onTap;

  final Widget leading;

  final Widget trailing;

  const BookListTile({Key key, @required this.bookList, @required this.onTap, this.leading, this.trailing}) :
        assert(bookList != null && onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      trailing: trailing,
      title: Text(bookList.name, style: TextStyle(fontSize: ktsMediumTextSize)),
      subtitle: Text( '${'contains'.tr} ${bookList.books.length} ${'elements'.tr}'),
      onTap: onTap,
    );
  }
}
