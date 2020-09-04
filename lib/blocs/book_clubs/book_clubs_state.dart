import 'package:sham_mobile/models/activity.dart';

class BookClubsState {}

class LoadingBookClubsState extends BookClubsState{

}

class BookClubsLoadedState extends BookClubsState{
  final List<Activity> bookClubs;

  BookClubsLoadedState(this.bookClubs);
}