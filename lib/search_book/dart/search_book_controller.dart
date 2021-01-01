import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/books/books_repository.dart';
import 'package:sham_mobile/models/book.dart';

class SearchBookController extends GetxController {
  static final _searchConfiguration = Book().obs;

  final results = <Book>[].obs;

  final suggestions = <String>[].obs;

  final TextEditingController textFieldController = TextEditingController();

  // true = show results; false = show suggestions
  final _showResults = false.obs;

  bool get showResults => _showResults.value;

  @override
  void onInit() {
    super.onInit();
    textFieldController.addListener(() {_searchConfiguration.value.title = textFieldController.text;});
  }

  void setSearchText(String text) {
    assert(text != null);
    _showResults.value = false;
    results.clear();
    suggestions.clear();
    if(text.isNotEmpty)
      suggestions.addAll(BooksRepository().allBooks
        .where((element) => element.title.toLowerCase().contains(RegExp(text.toLowerCase())))
        .map<String>((e) => e.title).toList());
  }

  void search() async {
    if(_configIsEmpty) return;
    _showResults.value = true;
    await Future.delayed(2.seconds);

    results.clear();

    results.addAll(BooksRepository().allBooks
        .where((element) => element.title.contains(RegExp(_searchConfiguration.value.title))));
  }

  bool get _configIsEmpty {
    Book searchConfig = _searchConfiguration.value;
    return searchConfig.title.isNullOrBlank
        && searchConfig.ageGroups.isEmpty
        && searchConfig.authors.isEmpty
        && searchConfig.categories.isEmpty
        && searchConfig.specialCategories.isEmpty
        && searchConfig.rating <= 0;
  }

  void clearSearch() {
    _showResults.value = false;
    results.clear();
    suggestions.clear();
    textFieldController.clear();
  }

  void selectSuggestionAtIndex(index) async {
    String suggestion = suggestions[index];
    textFieldController.value = TextEditingValue(text: suggestion,);
    textFieldController.selection = TextSelection(baseOffset: suggestion.length, extentOffset: suggestion.length);
    search();
  }
}