import 'package:get/get.dart';
import 'file:///E:/Prog/Flutter/sham_mobile/lib/books/books_controller.dart';

class BooksBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BooksController());
  }
}