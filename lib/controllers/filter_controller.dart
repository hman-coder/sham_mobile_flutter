import 'package:get/get.dart';
import 'package:sham_mobile/book_barrel.dart';
import 'package:sham_mobile/repositories/filters_repository.dart';
import 'package:sham_mobile/dialogs/filters_dialogs.dart';
import 'package:sham_mobile/models/book_filter.dart';

class FilterController extends GetxController {
  final _isLoading = false.obs;

  final FiltersRepository _repository = FiltersRepository();

  final Rx<BookSearchFilter> _filter;

  FilterController(BookSearchFilter currentFilter) : _filter = currentFilter.clone().obs;

  List<Author> get authors => _filter.value.authors;

  List<Category> get categories => _filter.value.categories;

  List<Category> get specialCategories => _filter.value.specialCategories;

  List<AgeGroup> get ageGroups => _filter.value.ageGroups;

  List<double> get ratingRange => [_filter.value.minRating, _filter.value.maxRating];

  List<int> get pagesRange => [_filter.value.minPages, _filter.value.maxPages];

  bool get isLoading => _isLoading.value;

  bool get hasRating => ratingRange[0] != -1;

  bool get hasPages => pagesRange[0] != -1;

  @override
  void onInit() {
    super.onInit();
  }

  showCategoriesDialog() async {
    final allCategories = _repository.categories;
    List<Category> selectedCategories = await Get.dialog<List<Category>>(BookFilterDialog<Category>(
      allObjects: allCategories,
      initiallySelectedObjects: _filter.value.categories,
      title: 'categories'.tr,
      displayName: (category) => category.name,
      showSearchField: true,)
    );

    if(selectedCategories != null) _filter.update((val) => val.categories = selectedCategories);
  }

  showSpecialCategoriesDialog() async{
    final allCategories = _repository.specialCategories;
    List<Category> selectedSpecialCategories = await Get.dialog<List<Category>>(BookFilterDialog<Category>(
      allObjects: allCategories,
      initiallySelectedObjects: _filter.value.specialCategories,
      title: 'special_categories'.tr,
      displayName: (category) => category.name,
      showSearchField: true,)
    );

    if(selectedSpecialCategories != null)
      _filter.update((val) => val.specialCategories = selectedSpecialCategories);
  }

  showAuthorsDialog() async {
    final allAuthors = _repository.authors;
    List<Author> selectedAuthors = await Get.dialog<List<Author>>(BookFilterDialog<Author>(
      allObjects: allAuthors,
      initiallySelectedObjects: _filter.value.authors,
      title: 'authors'.tr,
      displayName: (author) => author.name,
      showSearchField: true,)
    );

    if(selectedAuthors != null) _filter.update((val) => val.authors = selectedAuthors);
  }

  showAgeGroupsDialog() async {
    final allAgeGroups = _repository.ageGroups;
    List<AgeGroup> selectedGroups = await Get.dialog<List<AgeGroup>>(BookFilterDialog<AgeGroup>(
      allObjects: allAgeGroups,
      initiallySelectedObjects: _filter.value.ageGroups,
      title: 'age_groups'.tr,
      displayName: (ageGroup) => ageGroup.name,
      showSearchField: true,)
    );

    if(selectedGroups != null)
      _filter.update((val) => val.ageGroups = selectedGroups);
  }

  showRatingDialog() async {
    List<double> rating = await Get.dialog<List<double>>(RatingsDialog(
      lowerBound: _filter.value.minRating,
      upperBound: _filter.value.maxRating,
    ));

    if(rating != null)
      _filter.update((val) {
        val.minRating = rating[0];
        val.maxRating = rating[1];
      });
  }

  showPagesDialog() async {
    List<int> pagesRange = await Get.dialog<List<int>>(PagesDialog(
      lowerBound: _filter.value.minPages,
      upperBound: _filter.value.maxPages,
    ));

    if(pagesRange != null)
      _filter.update((val) {
        val.minPages = pagesRange[0];
        val.maxPages = pagesRange[1];
        print(val.minPages);
        print(val.maxPages);
      });
  }

  returnResult() {
    Get.back(result: this._filter.value);
  }

  clearAll() {
    _filter.update((val) {
      val.maxPages = -1;
      val.minPages = -1;

      val.minRating = -1;
      val.maxRating = -1;

      val.minPrice = -1;
      val.maxPrice = -1;

      val.authors = [];
      val.categories = [];
      val.specialCategories = [];
      val.ageGroups = [];
    });
  }
}