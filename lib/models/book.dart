import 'package:flutter/cupertino.dart';

import 'age_group.dart';
import 'author.dart';
import 'category.dart';
import 'offer.dart';

class Book with ChangeNotifier {
  // Main properties
  String title;
  bool isNew ;
  bool hasOffer ;
  String image ;
  List<Author> authors ;
  List<AgeGroup> ageGroups ;
  List<Category> specialCategories ;
  List<Category> categories ;
  List<Offer> offers;
  int count;
  int pages;

  /// Rating was turned into a list to allow minimum/maximum
  /// ratings during advanced search.
  List<double> rating;
  double price;

  bool _addedToLibrary;

  Book({this.title = '', this.authors = const [], this.rating = const [-1, -1],
    this.isNew, this.hasOffer, this.image, this.categories = const [],
    this.ageGroups = const [], this.specialCategories = const [],
    this.offers = const [], this.price = 0, bool bookmarked = false}) : _addedToLibrary = bookmarked ?? false;

  Book.noNulls() :
        title = '',
        isNew = false,
        hasOffer = false,
        image = '',
        authors = List(),
        ageGroups = List(),
        specialCategories = List(),
        categories = List(),
        offers = List(),
        price = 0,
        rating = [-1, -1],
        _addedToLibrary = false;

  Book.fromBook(Book book) :
        title = book.title,
        isNew = book.isNew,
        hasOffer = book.hasOffer,
        image = book.image,
        authors = book.authors,
        ageGroups = book.ageGroups,
        specialCategories = book.specialCategories,
        categories = book.categories,
        rating = book.rating,
        _addedToLibrary = false;

  // Setters
  set addedToLibrary(bool bookmarked) {
    _addedToLibrary = bookmarked;
    notifyListeners();
  }

  // Getters
  String get authorsAsString {
    String ret = '';
    authors.forEach((element) => ret += '${element.name} - ' );
    return ret.substring(0, ret.length - 3);
  }

  String get categoriesAsString{
    String ret = '';
    categories.forEach((element) => ret += '${element.name} - ');
    return ret.substring(0, ret.length - 3);
  }

  bool get addedToLibrary => _addedToLibrary;

  // Adders
  void addAuthor(Author author) {
    for(var i = 0; i < authors.length; i++) {
      if (authors[i] == author) return;
    }
    authors.add(author);
  }

  // Functionality
  bool equals(Book other) {
    return this.title == other.title &&
        other.authors == this.authors;
  }

  bool matches(Book other) {
    if(this.title.contains(other.title)) return true;

    for(Category cat in other.categories) {
      if(this.categories.contains(cat)) return true;
    }

    for(Category special in other.specialCategories) {
      if(this.specialCategories.contains(special)) return true;
    }


    for(Author author in other.authors) {
      if(this.authors.contains(author)) return true;
    }

    for(AgeGroup group in other.ageGroups) {
      if(this.ageGroups.contains(group)) return true;
    }

    return false;
  }

  @override
  String toString() {
    return "title: $title\n"
        "rating: $rating\n"
        "isNew: $isNew\n"
        "hasOffer: $hasOffer\n"
        "image: $image\n"
        "authors: ${authors != null ? authors.length : 'null'}\n"
        "categories: ${categories != null ? categories.length : 'null'}\n"
        "specials: ${specialCategories != null ? specialCategories.length : 'null'}\n"
        "ageGroups: ${ageGroups != null ? ageGroups.length : 'null'}";
  }
}