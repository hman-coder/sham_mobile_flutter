import 'package:equatable/equatable.dart';

import 'book.dart';

/// A list that contains bookmarked / liked books.
/// Exactly like playlists on any streaming app.
class BookList extends Equatable{
  int id;
  String name;
  List<Book> _books;

  List<Book> get books => _books;

  BookList({this.id, this.name, List<Book> books}) : _books = books ?? [];

  bool contains(Book book) => books.contains(book);

  void add(Book book) {
    books.add(book);
  }

  @override
  List<Object> get props => [name];
}