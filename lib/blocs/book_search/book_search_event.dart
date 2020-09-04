import 'package:sham_mobile/models/book.dart';

abstract class BookSearchEvent {}

class SwitchSearchModeEvent extends BookSearchEvent {}

class SearchEvent extends BookSearchEvent {
  final Book searchBook;

  SearchEvent(this.searchBook);
}