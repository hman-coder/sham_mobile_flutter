import 'package:sham_mobile/models/book.dart';

class BooksState {}

class LoadingState extends BooksState {}

class BooksLoadedState extends BooksState{
  final List<Book> books;

  BooksLoadedState(this.books);
}

class AllBooksState extends BooksLoadedState {
  AllBooksState(List<Book> books) : super(books);
}

class BookmarksState extends BooksLoadedState {
  BookmarksState(List<Book> books) : super(books);
}

class FilteredBooksState extends BooksLoadedState {
  FilteredBooksState(List<Book> books) : super(books);
}

class BlindDatesState extends BooksLoadedState {
  BlindDatesState(List<Book> books) : super(books);
}

class EmptyBookListState extends BooksState {}