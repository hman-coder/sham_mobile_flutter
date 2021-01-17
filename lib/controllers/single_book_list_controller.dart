
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/repositories/books_repository.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/book_list.dart';

/// Responsible for loading books of a specific
class SingleBookListController extends GetxController {
  final BookList bookList;

  final books = <Book>[].obs;

  bool get canLoadMore => false;

  final RefreshController refreshController = RefreshController();

  SingleBookListController(this.bookList);

  @override
  void onInit() {
    loadMoreBooks();
    super.onInit();
  }

  void addListenerToBooks(Function(List<Book>) listener) {
    books.listen(listener);
  }

  void loadMoreBooks() async {
    await Future.delayed(1.seconds);
    this.books.addAll(_mockBooks);
  }

  void removeBookFromList(Book book) async  {
    await Future.delayed(0.5.seconds);
    books.removeWhere((element) => book.title == element.title);
  }

  List<Book> get _mockBooks => BooksRepository().allBooks;
}