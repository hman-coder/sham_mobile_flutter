import 'package:sham_mobile/models/comment.dart';

abstract class ViewBookState {}

class LoadingCommentsState extends ViewBookState {}

class CommentsLoadedState extends ViewBookState {
  final List<Comment> comments;

  CommentsLoadedState(this.comments);
}