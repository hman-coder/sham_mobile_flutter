import 'package:sham_mobile/book_barrel.dart';

class BookSearchFilter {
  List<Author> authors ;

  List<AgeGroup> ageGroups ;

  List<Category> specialCategories ;

  List<Category> categories ;

  String title;

  double minRating;

  double maxRating;

  double minPrice;

  double maxPrice;

  double minPages;

  double maxPages;

  BookSearchFilter({
    this.authors = const [],
    this.ageGroups = const [],
    this.specialCategories = const [],
    this.categories = const [],
    this.title = '',
    this.minRating = -1,
    this.maxRating = -1,
    this.minPrice = -1,
    this.maxPrice = -1,
    this.minPages = -1,
    this.maxPages = -1});

  BookSearchFilter clone() {
    return BookSearchFilter(
      authors: this.authors,
      ageGroups: this.ageGroups,
      specialCategories: this.specialCategories,
      categories: this.categories,
      title: this.title,
      minPages: this.minPages,
      minRating: this.minRating,
      minPrice: this.minPrice,
      maxPages: this.maxPages,
      maxRating: this.maxRating,
      maxPrice: this.maxPrice,
    );
  }
}