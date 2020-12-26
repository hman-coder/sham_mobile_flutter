import 'package:flutter/material.dart';
import 'package:sham_mobile/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  final Widget trailing;

  const BookTile({Key key, @required this.book, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.authorsAsString),
      leading: Image.asset(book.image),
      trailing: trailing
    );
  }
}
