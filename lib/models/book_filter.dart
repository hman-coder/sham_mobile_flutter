import 'package:sham_mobile/barrels/book_barrel.dart';

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

  int minPages;

  int maxPages;

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

  bool matchesBook(Book book) {
    return authorsMatchedInBook(book) &&
        categoryMatchedInBook(book) &&
        specialCategoryMatchedInBook(book) &&
        ageGroupMatchedInBook(book) &&
        ratingMatchedInBook(book) &&
        pagesMatchedInBook(book);
  }

  bool authorsMatchedInBook(Book book) {
    if(authors.isEmpty) return true;

    for(Author author in book.authors) {
      if(this.authors.contains(author))
        return true;
    }

    return false;
  }

  bool categoryMatchedInBook(Book book) {
    if(categories.isEmpty) return true;

    for(Category category in book.categories) {
      if(this.categories.contains(category))
        return true;
    }

    return false;
  }

  bool specialCategoryMatchedInBook(Book book) {
    if(specialCategories.isEmpty) return true;

    for(Category category in book.specialCategories) {
      if(this.specialCategories.contains(category))
        return true;
    }

    return false;
  }

  bool ageGroupMatchedInBook(Book book) {
    if(ageGroups.isEmpty) return true;

    for(AgeGroup ageGroup in book.ageGroups) {
      if(this.ageGroups.contains(ageGroup))
        return true;
    }

    return false;
  }

  bool ratingMatchedInBook(Book book) {
    if(this.minRating == -1) return true;
    return book.rating >= this.minRating && book.rating <= this.maxRating;
  }

  bool pagesMatchedInBook(Book book) {
    if(this.minPages == -1) return true;
    return book.pages >= this.minPages && book.pages <= this.maxPages;
  }
}