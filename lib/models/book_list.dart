import 'book.dart';

/// A list that contains bookmarked / liked books.
/// Exactly like playlists on any streaming app.
class BookList {
  int id;
  String name;
  List<Book> books;

  BookList({this.id, this.name, this.books = const []});
}