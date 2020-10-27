import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/filter.dart';
import 'package:sham_mobile/books/main/repository/books_repository.dart';
import 'books_event.dart';
import 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  Filter _lastFilter = Filter.none;
  String _lastSearchString = "";

  BooksRepository repo = BooksRepository();

  BooksBloc() : super(LoadingState());

  @override
  Stream<BooksState> mapEventToState(BooksEvent event) async* {
    if(event is AllBooksEvent) yield* _handleAllBooksEvent();
    else if(event is BlindDatesEvent) yield* _handleBlindDatesEvent();
    else if(event is BookmarksEvent) yield* _handleBookmarksEvent();
    else if(event is FilterBooksEvent) yield* _handleFilterBooksEvent(event);
    else if(event is SearchBooksEvent) yield* _handleSearchBooksEvent(event);
    else if(event is AddToBookmarksEvent) yield* _handleAddToBookmarksEvent(event);
    else if(event is LoadMoreEvent) yield* _handleLoadMoreEvent();
  }

  BooksState _checkForEmptyListInState(BooksLoadedState state) {
    if(state.books.length == 0) return EmptyBookListState();

    return state;
  }

  Stream<BooksState> _handleAllBooksEvent() async* {
    yield LoadingState();

    yield _checkForEmptyListInState(AllBooksState(repo.allBooks));
  }

  Stream<BooksState> _handleBlindDatesEvent() async* {
    yield LoadingState();

    yield _checkForEmptyListInState(BlindDatesState(repo.blindDates));
  }

  Stream<BooksState> _handleBookmarksEvent() async*{
    yield LoadingState();
    yield _checkForEmptyListInState(BookmarksState(repo.testBookmarks.toList()));
  }

  Stream<BooksState> _handleFilterBooksEvent(FilterBooksEvent event) async* {

  }

  Stream<BooksState> _handleSearchBooksEvent(SearchBooksEvent event) async* {
    yield LoadingState();

    List<Book> returnedList = List();
    returnedList = repo.search(event.searchBook);

    yield AllBooksState(returnedList);
  }

  Stream<BooksState> _handleAddToBookmarksEvent(AddToBookmarksEvent event) async* {
    // Remove/add the book before changing bookmarked property
    // in order to avoid equatable errors.
    if(! event.book.bookmarked) repo.bookmarks.remove(event.book);
    else repo.bookmarks.add(event.book);

    event.book.bookmarked = ! event.book.bookmarked;
  }

  Stream<BooksState> _handleLoadMoreEvent() async* {

  }

}