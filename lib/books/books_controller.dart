import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/book_lists/book_lists_controller.dart';
import 'package:sham_mobile/book_lists/book_lists_dialog.dart';
import 'books_repository.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/book_list.dart';
import 'package:sham_mobile/user/user_controller.dart';


class BooksController extends GetxController {
  RefreshController _refreshController = RefreshController(
      initialRefresh: false
  );

  BooksRepository _repository = BooksRepository();

  var _obsBooks = <Book>[].obs;

  RefreshController get refreshController => _refreshController;

  List<Book> get books => _obsBooks.toList();

  @override
  void onInit() {
    Get.put(BookListsController(Get.find<UserController>().user.id));
    loadMoreBooks();
    super.onInit();
  }

  void addListenerToBooks(Function(List<Book>) listener) {
    _obsBooks.listen(listener);
  }

  void loadMoreBooks() async {
    printInfo(info: ': loading more books');
    await Future.delayed(3.seconds);
    _obsBooks.addAll(await _repository.loadBooks(Book(), _obsBooks.length-1));

    _refreshController.loadComplete();
  }

  void refreshBooks() async {
    await Future.delayed(3.seconds);
    _obsBooks.clear();
    _obsBooks.addAll(await _repository.loadBooks(Book(), _obsBooks.length-1));

    _refreshController.refreshCompleted();
  }

  Future<bool> addBookToBookList(Book book) async {
    BookList bookList = await Get.dialog(BookListsPickerDialog());

    if(bookList != null) {
      await Future.delayed(1.5.seconds);
      book.addedToLibrary = true;
      Get.find<BookListsController>().addBookToBookList(book, bookList);
      return true;
    }

    return false;
  }
}