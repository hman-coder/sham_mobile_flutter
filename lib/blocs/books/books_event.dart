import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/filter.dart';

class BooksEvent {}

class AllBooksEvent extends BooksEvent{}

class BlindDatesEvent extends BooksEvent {}

class BookmarksEvent extends BooksEvent {}

class FilterBooksEvent extends BooksEvent {
  final Filter filter;

  FilterBooksEvent(this.filter);
}

class SearchBooksEvent extends BooksEvent {
  final Book searchBook;

  SearchBooksEvent(this.searchBook);
}

class AddToBookmarksEvent extends BooksEvent {
  final Book book;

  AddToBookmarksEvent(this.book);
}

class LoadMoreEvent extends BooksEvent {}

class SwitchTabsEvent extends BooksEvent{}

class SwitchBookmarksEvent extends BooksEvent{}