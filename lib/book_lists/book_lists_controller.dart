import 'package:get/get.dart';
import 'package:sham_mobile/error/error_controller.dart';
import 'package:sham_mobile/models/book_list.dart';

class BookListsController extends GetxController {
  final _bookLists = List<BookList>().obs;

  List<BookList> get bookLists => _bookLists.toList();

  final int userId;

  BookListsController(this.userId);

  @override
  void onInit() {
    setMockValues();
    super.onInit();
  }

  void setMockValues() {
    _bookLists.add(BookList(name: 'wishlist'.tr, id: 1));
    _bookLists.add(BookList(name: 'bookmarks'.tr, id: 2));
  }

  /// Returns whether the book was added or not
  Future<bool> addBookList(BookList bookList) async {
    if(bookList?.name == null || bookList.name.isEmpty) {
      Get.find<ShamErrorController>()
          .showError(ShamError(
          severity: ErrorSeverity.mild,
          displayType: ErrorDisplayType.snackbar,
          message: 'text_is_empty'.tr)
      );
      return false;
    }

    else {
      await Future.delayed(2.seconds);
      _bookLists.add(bookList);
      return true;
    }
  }

  void removeBookList(BookList bookList) async {
    assert (bookList?.id != null && bookList.id != 0);
    bool confirmed = await Get.find<ShamErrorController>()
        .showConfirmation(title: 'confirm'.tr, message: 'confirm_book_list_removal'.tr);

    if(confirmed) {
      await Future.delayed(2.seconds);
      _bookLists.removeWhere((item) => item.id == bookList.id);
    }
  }

  void updateBookList(BookList bookList) async {

  }
}