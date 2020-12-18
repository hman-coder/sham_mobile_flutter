import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/models/book.dart';
import 'book_search_state.dart';
import 'book_search_event.dart';

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  /// Needed to notify the booksBloc with the current tab index
  /// when search is cancelled.
  final TabController tabController;

  // final BooksBloc booksBloc;

  static Book _lastSearchBook = Book();

  Book get lastSearchBook => _lastSearchBook;

  BookSearchBloc({@required this.tabController})
      : super(SearchModeOffState());

  @override
  Stream<BookSearchState> mapEventToState(BookSearchEvent event) async*{
    if (event is SwitchSearchModeEvent) yield* _handleSearchModeEvent(event);

    else if (event is SearchEvent) yield* _handleSearchBooksEvent(event);
  }

  /// Used to prevent overlapping requests
  Timer lastSearchRequest;

  void _resetLastSearchRequest() {
    if(lastSearchRequest != null && lastSearchRequest.isActive)
      lastSearchRequest.cancel();
  }

  Stream<BookSearchState> _handleSearchModeEvent(SwitchSearchModeEvent event) async* {
    _resetLastSearchRequest();

    if(state is SearchModeOnState) yield SearchModeOffState();

    else if (state is SearchModeOffState) yield SearchModeOnState();
  }

  Stream<BookSearchState>_handleSearchBooksEvent(SearchEvent event) async* {
    _resetLastSearchRequest();
    _lastSearchBook = event.searchBook;

    lastSearchRequest = Timer(Duration(milliseconds: 300), () {
      // booksBloc.add(SearchBooksEvent(_lastSearchBook));
    });
  }
}