import 'package:sham_mobile/helpers/string_helper.dart';
import 'package:sham_mobile/models/age_group.dart';
import 'package:sham_mobile/models/comment.dart';
import 'package:sham_mobile/models/author.dart';
import 'package:sham_mobile/models/book.dart';
import 'package:sham_mobile/models/category.dart';
import 'package:sham_mobile/models/offer.dart';

class BooksRepository{

  Future<List<Book>> loadBooks(Book filterBook, [int fromIndex]) async {
    if(filterBook.title.isEmpty && filterBook.authors.isEmpty &&
        filterBook.categories.isEmpty && filterBook.ageGroups.isEmpty &&
        filterBook.specialCategories.isEmpty && filterBook.rating[0] == 0 && (filterBook.rating[0] == 0 || filterBook.rating[0] == 5)) {
      return allBooks;
    }

    List<Book> list = List();

    for (var i = 0; i < allBooks.length; i++) {
      Book book = allBooks[i];

      if (_eligibleForSearch(filterBook, book)) list.add(book);
    }

    return list;
  }

  List<Comment> testComments = [
    Comment(
      body: "كتاب رائع وقيم جداً. أنصح الجميع بقراءته",
      userImage: "assets/images/user_icon.png",
      username: "مستخدم جديد",
      rating: 4,
    ),

    Comment(
        body: "لقد غير هذا الكتاب نظرتي إلى كثير من الأمور.\n"
            "من أفضل 5 كتب قرأتها في حياتي.",
        userImage: "assets/images/user_icon.png",
        username: "مستخدم جديد",
        rating: 5
    ),

    Comment(
        body: "تعليق طويل جداً عن مدى روعة الكتاب وتألقه وجبروته وعنفوانه وجماله وكل هذه الأشياء الجميلة، تعليق طويل جداً عن مدى روعة الكتاب وتألقه وجبروته وعنفوانه وجماله وكل هذه الأشياء الجميلة، تعليق طويل جداً عن مدى روعة الكتاب وتألقه وجبروته وعنفوانه وجماله وكل هذه الأشياء الجميلة",
        userImage: "assets/images/hisham.png",
        username: "هشام صديق",
        rating: 3.2
    ),
  ];

  Future<List<Comment>> getCommentsForBook(Book book) async {
    Future.delayed(Duration(seconds: 2));
    return testComments;
  }

  bool _eligibleForSearch(Book searchBook, Book book) {
    String normalizedBookTitle = StringHelper.normalizeArabicText(book.title);
    String normalizedSearchBookTitle = StringHelper.normalizeArabicText(searchBook.title);

    bool title = (searchBook.title == null || normalizedBookTitle.contains(normalizedSearchBookTitle));
    bool authors = searchBook.authors.isEmpty || _checkIfListAppliesForSearch(book.authors, searchBook.authors);
    bool categories = searchBook.categories.isEmpty || _checkIfListAppliesForSearch(book.categories, searchBook.categories);
    bool specials = searchBook.specialCategories.isEmpty || _checkIfListAppliesForSearch(book.specialCategories, searchBook.specialCategories);
    bool groups = searchBook.ageGroups.isEmpty || _checkIfListAppliesForSearch(book.ageGroups, searchBook.ageGroups);
    bool rating = (searchBook.rating[0] == -1 || (book.rating[0] >= searchBook.rating[0] && book.rating[0] <= searchBook.rating[1]));

    return title && authors && categories && specials && groups && rating;
  }

  bool _checkIfListAppliesForSearch<T>(List<T> searchList, List<T> list) {
    for(T element in searchList)
      if (list.contains(element)) return true;

    return false;
  }

  static final List<Book> _bookmarks = List();

  List<Book> get bookmarks => _bookmarks;

  Iterable<Book> get testBookmarks sync*{
    for(Book book in allBooks) {
      if(book.addedToLibrary) yield book;
    }
  }

  final List<Book> blindDates = [
    Book(
      title: "شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى",
      image: "assets/images/blind_date_1.jpg",
    ),
    Book(
      title: "شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى",
      image: "assets/images/blind_date_2.jpg",
    ),
    Book(
      title: "شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى",
      image: "assets/images/blind_date_3.jpg",
    )
  ];

  final List<Book> allBooks = [
    Book(
      title: 'اثنا عشر قانوناً للحياة: ترياق للفوضى',
      rating: [4.2],
      price: 5000,
      authors: [Author(name: 'جوردان ب. بيترسون')],
      isNew: true,
      hasOffer: false,
      image: 'assets/images/12_rules.jpg',
      categories: <Category>[
        Category(name: 'تنمية بشرية'), Category(name: 'فلسفة') , Category(name: 'تطوير ذاتي')
      ],
      specialCategories: <Category>[
        Category(name: 'سيغير منظورك للحياة')
      ],
      ageGroups: <AgeGroup>[
        AgeGroup.adolescents(), AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: []
    ),
    Book(
      title: 'الجريمة والعقاب',
      rating: [4],
      authors: [Author(name: 'فيدور دوستويفسكي')],
      isNew: false,
      hasOffer: false,
      price: 4500,
      image: 'assets/images/crime_and_punishment.jpg',
      categories: <Category>[
        Category(name: 'رعب'), Category(name: 'روايات'), Category(name: 'أدب روسي')
      ],
      specialCategories: <Category>[

      ],
      ageGroups: <AgeGroup>[
        AgeGroup.aged(), AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: [
//          BookComment.full('كتاب رائع', null, 4),
//        ]
    ),
    Book(
      title: 'المرجع الأكيد في لغة الجسد',
      rating: [3.5],
      authors: [Author(name: 'آلان وباربارا بييز')],
      isNew: false,
      price: 4200,
      hasOffer: false,
      image: 'assets/images/body_language.jpg',
      categories: <Category>[
        Category(name: 'تنمية بشرية'), Category(name: 'تطوير ذاتي')
      ],
      specialCategories: <Category>[
        Category(name: 'يغير نظرتك للناس على الفور')
      ],
      ageGroups: <AgeGroup>[
        AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: [
//          BookComment.full('كتاب رائع', null, 4),
//          BookComment.full('كتاب أكثر من رائع', null, 3),
//        ]
    ),
    Book(
      title: 'أسرار عقلية المليونير',
      authors: [Author(name: 'توماس هارف إيكر')],
      isNew: true,
      rating: [3],
      price: 3000,
      hasOffer: true,
      image: 'assets/images/mill.png',
      categories: <Category>[
        Category(name: 'تنمية بشرية'), Category(name: 'تجارة'), Category(name: 'تطوير ذاتي')
      ],
      specialCategories: <Category>[
        Category(name: 'ستصبح ثرياً بعد قراءته')
      ],
      ageGroups: <AgeGroup>[
        AgeGroup.aged(), AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: [
//          BookComment.full('كتاب رائع', null, 3),
//          BookComment.full('كتاب أكثر من رائع', null, 3),
//        ]
    ),
    Book(
      title: 'صورة دوريان غراي',
      authors: [Author(name: 'أوسكار وايلد')],
      rating: [5],
      price: 3800,
      isNew: false,
      hasOffer: true,
      image: 'assets/images/dorian.png',
      categories: <Category>[
        Category(name: 'أدب إنكليزي'), Category(name: 'رعب')
      ],
      specialCategories: <Category>[
        Category(name: 'ستقرؤه أكثر من مرة')
      ],
      ageGroups: <AgeGroup>[
        AgeGroup.aged(), AgeGroup.adults(), AgeGroup.midLife()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: [
//          BookComment.full('كتاب رائع', null, 5),
//          BookComment.full('كتاب أكثر من رائع', null, 5),
//          BookComment.full('كتاب أكثر من أكثر من رائع', null, 5),
//        ]
    ),
    Book(
      title: 'فن اللامبالاة',
      authors: [Author(name: 'مارك مانسون')],
      rating: [2.9],
      price: 3000,
      isNew: true,
      hasOffer: false,
      image: 'assets/images/fuck.png',

      categories: <Category>[
        Category(name: 'تنمية بشرية'), Category(name: 'تطوير ذاتي')
      ],

      specialCategories: <Category>[
        Category(name: 'ستقرؤه أكثر من مرة')
      ],

      ageGroups: <AgeGroup>[
        AgeGroup.adolescents(), AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],
//      comments: [],
    ),

    Book(
      title: 'اثنا عشر قانوناً للحياة: ترياق للفوضى',
      rating: [4.2],
      price: 5000,
      authors: [Author(name: 'جوردان ب. بيترسون')],
      isNew: true,
      hasOffer: false,
      image: 'assets/images/12_rules.jpg',
      categories: <Category>[
        Category(name: 'تنمية بشرية'), Category(name: 'فلسفة') , Category(name: 'تطوير ذاتي')
      ],
      specialCategories: <Category>[
        Category(name: 'سيغير منظورك للحياة')
      ],
      ageGroups: <AgeGroup>[
        AgeGroup.adolescents(), AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: []
    ),
    Book(
      title: 'الجريمة والعقاب',
      rating: [4],
      authors: [Author(name: 'فيدور دوستويفسكي')],
      isNew: false,
      hasOffer: false,
      price: 4500,
      image: 'assets/images/crime_and_punishment.jpg',
      categories: <Category>[
        Category(name: 'رعب'), Category(name: 'روايات'), Category(name: 'أدب روسي')
      ],
      specialCategories: <Category>[

      ],
      ageGroups: <AgeGroup>[
        AgeGroup.aged(), AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: [
//          BookComment.full('كتاب رائع', null, 4),
//        ]
    ),
    Book(
      title: 'المرجع الأكيد في لغة الجسد',
      rating: [3.5],
      authors: [Author(name: 'آلان وباربارا بييز')],
      isNew: false,
      price: 4200,
      hasOffer: false,
      image: 'assets/images/body_language.jpg',
      categories: <Category>[
        Category(name: 'تنمية بشرية'), Category(name: 'تطوير ذاتي')
      ],
      specialCategories: <Category>[
        Category(name: 'يغير نظرتك للناس على الفور')
      ],
      ageGroups: <AgeGroup>[
        AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: [
//          BookComment.full('كتاب رائع', null, 4),
//          BookComment.full('كتاب أكثر من رائع', null, 3),
//        ]
    ),
    Book(
      title: 'أسرار عقلية المليونير',
      authors: [Author(name: 'توماس هارف إيكر')],
      isNew: true,
      rating: [3],
      price: 3000,
      hasOffer: true,
      image: 'assets/images/mill.png',
      categories: <Category>[
        Category(name: 'تنمية بشرية'), Category(name: 'تجارة'), Category(name: 'تطوير ذاتي')
      ],
      specialCategories: <Category>[
        Category(name: 'ستصبح ثرياً بعد قراءته')
      ],
      ageGroups: <AgeGroup>[
        AgeGroup.aged(), AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: [
//          BookComment.full('كتاب رائع', null, 3),
//          BookComment.full('كتاب أكثر من رائع', null, 3),
//        ]
    ),
    Book(
      title: 'صورة دوريان غراي',
      authors: [Author(name: 'أوسكار وايلد')],
      rating: [5],
      price: 3800,
      isNew: false,
      hasOffer: true,
      image: 'assets/images/dorian.png',
      categories: <Category>[
        Category(name: 'أدب إنكليزي'), Category(name: 'رعب')
      ],
      specialCategories: <Category>[
        Category(name: 'ستقرؤه أكثر من مرة')
      ],
      ageGroups: <AgeGroup>[
        AgeGroup.aged(), AgeGroup.adults(), AgeGroup.midLife()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],

//        comments: [
//          BookComment.full('كتاب رائع', null, 5),
//          BookComment.full('كتاب أكثر من رائع', null, 5),
//          BookComment.full('كتاب أكثر من أكثر من رائع', null, 5),
//        ]
    ),
    Book(
      title: 'فن اللامبالاة',
      authors: [Author(name: 'مارك مانسون')],
      rating: [2.9],
      price: 3000,
      isNew: true,
      hasOffer: false,
      image: 'assets/images/fuck.png',

      categories: <Category>[
        Category(name: 'تنمية بشرية'), Category(name: 'تطوير ذاتي')
      ],

      specialCategories: <Category>[
        Category(name: 'ستقرؤه أكثر من مرة')
      ],

      ageGroups: <AgeGroup>[
        AgeGroup.adolescents(), AgeGroup.adults(), AgeGroup.teens()
      ],

      offers: [
        Offer(description: 'حسم 20% على الكتاب لمستخدمي التطبيق')
      ],
//      comments: [],
    ),
  ];
}