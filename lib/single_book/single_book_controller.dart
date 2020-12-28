import 'package:get/get.dart';
import 'package:sham_mobile/books/books_repository.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/comment.dart';

class SingleBookController extends GetxController {
  final Rx<Book> _book;

  Book get book => _book.value;

  var _comments = <Comment>[];

  List<Comment> get comments => _comments.toList();

  var _isLoadingComments = true.obs;

  bool get isLoadingComments => _isLoadingComments.value;

  SingleBookController(Book book) : _book = book.obs;

  @override
  void onInit() {
    _loadComments();
    super.onInit();
}

  _loadComments() {
    Future.delayed(6.seconds).then((value) {
      _isLoadingComments.value = false;
      _comments.addAll(BooksRepository().testComments);

    });
  }

}