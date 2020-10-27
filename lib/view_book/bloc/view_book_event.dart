import 'package:sham_mobile/models/comment.dart';

abstract class ViewBookEvent {}

class LoadMoreCommentsEvent extends ViewBookEvent {}

class AddReviewEvent extends ViewBookEvent {
  final Comment comment;

  AddReviewEvent(this.comment);
}