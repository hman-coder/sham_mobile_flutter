import 'package:get/get.dart';
import 'package:sham_mobile/controllers/books_controller.dart';

class BooksBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BooksController());
  }
}