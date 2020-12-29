import 'package:get/get.dart';
import 'package:sham_mobile/books/books_repository.dart';
import 'package:sham_mobile/error/error_controller.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/comment.dart';
import 'package:sham_mobile/user/user_controller.dart';

class SingleBookController extends GetxController {
  final Rx<Book> _book;

  var _comments = <Comment>[];

  var _isLoadingComments = true.obs;

  SingleBookController(Book book) : _book = book.obs;

  Book get book => _book.value;

  List<Comment> get comments => _comments.toList();

  bool get isLoadingComments => _isLoadingComments.value;

  @override
  void onInit() {
    _loadComments();
    super.onInit();
  }

  addToPlayList() async {
    await Future.delayed(3.seconds);
    _book.update((val) => val.addedToLibrary = ! (val.addedToLibrary));
  }

  _loadComments() {
    Future.delayed(6.seconds).then((value) {
      _isLoadingComments.value = false;
      _comments.addAll(BooksRepository().testComments);
    });
  }

  void onReserveBook() async {
    if(await Get.find<UserController>().eligibleForServices) {
      ShamMessageController msgCntrl = Get.find<ShamMessageController>();
      if(await msgCntrl.showConfirmation(
          title: "deliver_book".tr,
          message: '${'deliver_book_confirmation'.tr}${'question_mark'.tr}'))

        msgCntrl.showMessage(ShamMessage(
          displayType: MessageDisplayType.snackbar,
          severity: MessageSeverity.mild,
          message: 'request_sent'
        ));


    }
  }

}