import 'dart:async';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sham_mobile/controllers/blind_dates_controller.dart';
import 'package:sham_mobile/controllers/sham_controller.dart';
import 'package:sham_mobile/ui/books/blind_dates_ui.dart';
import 'package:sham_mobile/controllers/book_lists_controller.dart';
import 'package:sham_mobile/ui/dialogs/book_lists_dialogs.dart';
import 'package:sham_mobile/controllers/filter_controller.dart';
import 'package:sham_mobile/ui/filters_ui.dart';
import 'package:sham_mobile/models/book_filter.dart';
import 'package:sham_mobile/controllers/search_book_controller.dart';
import 'package:sham_mobile/ui/books/search_book_ui.dart';
import 'package:sham_mobile/repositories/books_repository.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/book_list.dart';
import 'package:sham_mobile/controllers/user_controller.dart';
import 'package:sham_mobile/ui/books/book_lists_ui.dart';

class BooksController extends ShamController {
  static BookSearchFilter _currentSearchFilter = BookSearchFilter();

  RefreshController refreshController = RefreshController();

  BooksRepository _repository = BooksRepository();

  var _obsBooks = <Book>[].obs;

  List<Book> get books => _obsBooks.toList();

  @override
  void onInit() {
    Get.put(BookListsController(Get.find<UserController>().user.id));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadMoreBooks();
  }

  Future loadMoreBooks() async {
    printInfo(info: ': loading more books');
    await Future.delayed(3.seconds);
    _obsBooks.addAll(_repository.allBooks);

    refreshController.loadComplete();
  }

  Future refreshBooks() async {
    await Future.delayed(3.seconds);
    _obsBooks.clear();
    _obsBooks.addAll(await _repository.allBooks);

    refreshController.refreshCompleted();
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

  void goToBlindDates() {
    Get.to(GetBuilder(
      builder: (controller) => BlindDatesUI(),
      init: BlindDatesController(),
    )
    );
  }

  void goToBookLists() {
    Get.to(BookListsUI());
  }

  void goToSearch() {
    Get.to(GetBuilder(
      builder: (controller) => SearchBookUI(),
      init: SearchBookController(),
    )
    );
  }

  void goToFilters() async {
    var newSearchFilter = await Get.to<BookSearchFilter>(
        GetBuilder<FilterController>(
          init: FilterController(_currentSearchFilter),
          builder: (_) => FiltersUI()
        )
    );

    if(newSearchFilter != null) _applyFilter(newSearchFilter);
  }

  void _applyFilter(BookSearchFilter filter) {
    _currentSearchFilter = filter;
    var filteredBooks = _repository.allBooks.where((book) => _currentSearchFilter.matchesBook(book));
    _obsBooks.clear();
    _obsBooks.addAll(filteredBooks);
  }
}