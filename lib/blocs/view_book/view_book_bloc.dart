import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/comment.dart';
import 'package:sham_mobile/repositories/books_repository.dart';

import 'view_book_event.dart';
import 'view_book_state.dart';

class ViewBookBloc extends Bloc<ViewBookEvent, ViewBookState> {
  BooksRepository repo = BooksRepository();

  final Book book;

  ViewBookBloc(this.book) : super(LoadingCommentsState());

  @override
  Stream<ViewBookState> mapEventToState(event) async* {
    if(event is LoadMoreCommentsEvent) yield* _handleLoadMoreCommentsEvent(event);
    if(event is AddReviewEvent) yield* _handleAddCommentEvent(event);
  }

  Stream<ViewBookState> _handleLoadMoreCommentsEvent(LoadMoreCommentsEvent event) async* {
    List<Comment> comments = await repo.getCommentsForBook(book);
    yield CommentsLoadedState(comments);
  }

  Stream<ViewBookState> _handleAddCommentEvent(AddReviewEvent event) async*{
    repo.testComments.add(event.comment);
    List<Comment> comments = await repo.getCommentsForBook(book);
    yield CommentsLoadedState(comments);
  }

}
