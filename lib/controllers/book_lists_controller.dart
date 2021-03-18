import 'package:get/get.dart';
import 'package:sham_mobile/controllers/single_book_list_controller.dart';
import 'package:sham_mobile/ui/books/single_book_list_ui.dart';
import 'package:sham_mobile/ui/dialogs/book_lists_dialogs.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/book_list.dart';

class BookListsController extends GetxController {
  final _bookLists = List<BookList>().obs;

  List<BookList> get bookLists => _bookLists.toList();

  final int userId;

  BookListsController(this.userId);

  @override
  void onInit() {
    _setMockValues();
    super.onInit();
  }

  void _setMockValues() {
    _bookLists.add(BookList(name: 'wishlist'.tr, id: 1));
    _bookLists.add(BookList(name: 'bookmarks'.tr, id: 2));
  }

  void addBookToBookList(Book book, BookList bookList) {
    BookList localBookList = _bookLists.firstWhere((element) => element.id == bookList.id);
    if(! localBookList.contains(book))
      localBookList.add(book);
  }

  void addBookList() async {
    String name = await _showEnterBookListNameDialog();

    if(name == null) return;      // User pressed cancel

    BookList bookList = BookList(name: name);

    // If bookList doesn't already exists, then add:
    if(! (await _checkIfBookListExists(bookList))) {
      await Future.delayed(1.5.seconds);
      _bookLists.add(bookList..id = bookLists.length);
    }
  }

  /// Shows a dialog for the user to enter the desired name.
  /// If the user enters an empty String, it shows the
  /// appropriate message.
  Future<String> _showEnterBookListNameDialog() async {
    String name = await Get.dialog(AddOrEditBookListDialog());

    if(name != null && name?.isEmpty) {
      Get.find<ShamMessageController>()
          .showMessage(ShamMessage(
          severity: MessageSeverity.mild,
          displayType: MessageDisplayType.snackbar,
          message: 'text_is_empty'.tr)
      );

      return null;
    }

    return name;
  }

  /// Checks if bookList exists and shows appropriate dialog
  /// if it does.
  Future<bool> _checkIfBookListExists(BookList bookList) async {
    bool bookListExists = bookLists.contains(bookList);

    if (bookListExists){
      Get.find<ShamMessageController>()
          .showMessage(ShamMessage(
          severity: MessageSeverity.mild,
          displayType: MessageDisplayType.snackbar,
          message: 'list_already_exists'.tr)
      );
      return true;
    }

    return false;
  }

  void editBookList(BookList bookList) async {
    String newBookListName = await _showEnterBookListNameDialog();

    // User pressed cancel
    if(newBookListName == null) return;

    BookList newBookList = BookList(id: bookList.id, name: newBookListName);
    if(!(await _checkIfBookListExists(newBookList))) {
      await Future.delayed(1.seconds);

      _bookLists.remove(bookList);
      _bookLists.add(newBookList);
    }
  }

  void removeBookList(BookList bookList) async {
    assert (bookList?.id != null && bookList.id != 0);
    bool confirmed = await Get.find<ShamMessageController>()
        .showConfirmation(title: 'confirm'.tr, message: 'confirm_book_list_removal'.tr);

    if(confirmed) {
      await Future.delayed(2.seconds);
      _bookLists.removeWhere((item) => item.id == bookList.id);
    }
  }

  onBookListPressed(BookList bookList) async {
    Get.to(GetBuilder<SingleBookListController>(
      init: SingleBookListController(bookList),
      builder: (controller) => SingleBookListUI()
    )
    );
  }
}