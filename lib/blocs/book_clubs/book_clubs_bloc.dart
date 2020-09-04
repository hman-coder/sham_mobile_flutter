import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/repositories/book_clubs_repository.dart';

import 'book_clubs_event.dart';
import 'book_clubs_state.dart';

class BookClubsBloc extends Bloc<BookClubsEvent, BookClubsState>{
  BookClubsRepository _repository;

  BookClubsBloc() :
        _repository = BookClubsRepository(),
        super(LoadingBookClubsState()) {
    _repository.addListener(() => this.add(BookClubsRequestedEvent()));
  }

  @override
  Stream<BookClubsState> mapEventToState(BookClubsEvent event) async* {
    if(event is BookClubsRequestedEvent) yield* _handleBookClubsRequestedEvent(event);

  }

  Stream<BookClubsState> _handleBookClubsRequestedEvent(BookClubsRequestedEvent event) async* {
    yield BookClubsLoadedState(_repository.bookClubs);
  }
}