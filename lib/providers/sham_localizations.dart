import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShamLocalizations {
  final Locale locale = Locale('ar');

  ShamLocalizations(Locale locale);

  static ShamLocalizations of(BuildContext context) {
    return Localizations.of<ShamLocalizations>(context, ShamLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // A
      'all' : 'All',
      'all_info_obscured_message' : 'Information is obscured; only you and your family can see it',
      'about_app' : 'About app',
      'about_sham' : 'About Sham',
      'accept' : 'Accept',
      'account' : 'Account',
      'account_needed_message' : 'You must have an account to perform this action',
      'activities' : 'Activities',
      'add_review' : 'Add review',
      'address' : 'Address',
      'address_helper_text' : 'This information will help us deliver some services (like delivering books) to your doorstep.',
      'address_hint' : 'City, street, building no., floor',

      'advanced_search' : 'Advanced search',
      'advanced_search_description' : 'Select the filters you want to add to '
          'your search by selecting elements from the lists below',
      'age_group' : 'Age group',
      'age_groups' : 'Age groups',

      'authors' : 'Authors',

      // B
      'books' : 'Books',
      'book_clubs' : 'Book clubs',
      'book_reserved_successfully' : 'Book has been successfully reserved',
      'blind_dates' : 'Blind dates',
      'bookmarks' : 'Bookmarks',

      // C
      'cancel' : 'Cancel',
      'categories' : 'Categories',
      'category' : 'Category',
      'claim_book' : 'Please claim your book within this period',
      'clubs' : 'Clubs',
      'comma' : ',',
      'comments' : 'Comments',
      'contact_us' : 'Contact us',
      'change_language' : 'Change language',
      'create_new_account' : 'Create a new account',
      'create_account_to_complete_action' : 'You have to create an account to perform this action',

      // E
      'edit' : 'Edit',
      'edit_book_review' : 'Press here to edit your review',
      'edit_name' : 'Edit name',
      'edit_phone_number' : 'Edit phone number',
      'edit_address' : 'Edit address',
      'enter_review' : 'Enter review',
      'error_report_message' : 'Please report this exception by pressing the button below. This requires an internet connection.',
      'error_while_building_ui' : 'An error occurred while building your interface.',
      'error_report_button' : 'Report',

      //F
      'facebook_sign_in' : 'Facebook account',
      'family' : 'family',
      'family_info' : 'Family information',
      'frequency' : 'Frequency',
      'from' : 'From',

      // G
      'get_book' : 'Get book now',
      'google_sign_in' : 'Google account',

      // H
      'hide' : 'hide',

      // M
      'more_info' : 'More info...',

      // N
      'new_user' : 'New user',
      'next_session' : 'Next session',
      'no_books_found' : 'No books here yet',

      // O
      'offers' : 'Offers',

      // P
      'password' : 'Password',
      'participants' : 'Participants',
      'personal_info' : 'Personal information',
      'phone_number' : 'Phone number',
      'press_to_reivew_book' : 'Press here to review book',
      'press_item_to_edit' : 'Press an item to edit it',
      'price' : 'Price',
      'priority_score' : 'Priority score',
      'priority_score_obscured' : 'Priority score obscured',
      'priority_score_high' : 'High',
      'priority_score_low' : 'Low',
      'priority_score_mid' : 'Mid',

      // S
      'search' : 'Search',
      'save' : 'Save',
      'saved' : 'Saved',
      'search_author_hint': 'Search authors',
      'search_book_hint': 'Search book title',
      'session_duration' : 'Session duration',
      'sham_sign_in' : 'or sign in with Sham',
      'sign_in' : 'Login',
      'sign_in_description' : 'login description',
      'sign_in_or_create_new_account' : 'Sign in or create a new account',
      'sign_up' : 'Sign up',
      'similar_books' : 'Similar books',
      'social_sign_in' : 'Sign in with',
      'special_categories' : 'Special categories',
      'submit' : 'Submit',

      // R
      'rating' : 'Rating',
      'remove_all' : 'Remove all',
      'reserve_book' : 'Reserve book',
      'reserve_book_request_high_priority' : 'Because you have a high priority score, your book will be reserved for',
      'reserve_book_request_medium_priority_1' : 'You have a medium priority score, so you can reserve a book for only',
      'reserve_book_request_low_priority' : 'We\'re sorry, but your priority score doesn\'t allow you to reserve this book',
      'reserve_book_request_submitted' : 'Your request has been submitted',
      'review' : 'Review',

      // T
      'text_is_empty' : 'You entered an empty text',
      'title' : 'Sham Bookstore',
      'to' : 'To',
      'to_learn_more_about_priority' : 'To learn more about priority score, press "Priority score" below',

      // U
      'use_app_without_account' : 'Use the app without an account',
      'user_profile' : 'User profile',
      'username' : 'Username',

      // V
      'view_list' : 'View list',
      'view_more' : 'View more',
    },

    'ar': {
      // A
      'all' : 'الكل',
      'all_info_obscured_message' : 'هذه المعلومات مخفية، ولا يراها إلا أنت وعائلتك',
      'about_app' : 'حول التطبيق',
      'about_sham' : 'حول شام',
      'accept' : 'موافق',
      'account': 'الحساب',
      'account_needed_message' : 'يجب أن يكون لديك حساب لتستطيع المتابعة',
      'activities' : 'النشاطات',
      'address' : 'العنوان',
      'address_helper_text' : 'ستساعدنا هذه المعلومات في تقديم خدمات محددة (كإيصال الكتب) عند منزلك',
      'address_hint' : 'المدينة، الحي، الشارع، رقم البناء، الطابق',
      'add_book_review' : 'اضغط هنا لإضافة تقييم',
      'advanced_search' : 'بحث متقدم',
      'advanced_search_description' : 'اختر العناصر التي تود تخصيص بحثك فيها '
          'عن طريق إضافتها أو إزالتها من القوائم أدناه',
      'age_group' : 'الفئة العمرية',
      'age_groups' : 'الفئات العمرية',
      'authors' : 'الكُتّاب',

      // B
      'blind_dates' : 'موعد أعمى',
      'book_clubs' : 'نوادي الكتاب',
      'bookmarks' : 'المفضلة',
      'books' : 'الكتب',
      'book_reserved_for' : 'سيتم حجز نسخة من هذا الكتاب لمدة',
      'book_reserved_successfully' : 'تم حجز نسخة من هذا الكتاب لك',

      // C
      'cancel' : 'إلغاء',
      'categories' : 'التصنيفات',
      'category' : 'التصنيف',
      'claim_book' : 'يرجى أخذ نسختك من الكتاب في هذه الفترة',
      'clubs' : 'النوادي',
      'comma' : '،',
      'comments' : 'التعليقات',
      'contact_us' : 'اتصل بنا',
      'change_language' : 'تغيير اللغة',
      'create_new_account' : 'إنشاء حساب جديد',

      //F
      'facebook_sign_in' : 'حساب Facebook',
      'family' : 'العائلة',
      'family_info' : 'معلومات العائلة',
      'frequency' : 'التكرار',
      'from' : 'من',

      // E
      'edit' : 'تعديل',
      'edit_book_review' : 'اضغط هنا لتعديل تقييمك',
      'edit_username' : 'تعديل الاسم',
      'edit_phone_number' : 'تعديل رقم الهاتف',
      'edit_address' : 'تعديل العنوان',
      'enter_review' : 'أدخل التقييم',
      'error_report_message' : 'نرجو التبليغ عن هذا الخطأ عن طريق الضغط على الزر أدناه. يتطلب ذلك اتصالاً بالإنترنت.',
      'error_while_building_ui' : 'حصل خطأ أثناء بناء الواجهة',
      'error_report_button' : 'التبليغ',

      // G
      'get_book' : 'احصل على الكتاب',
      'google_sign_in' : 'حساب Google',

      // H
      'hide' : 'إخفاء',

      // M
      'more_info' : 'المزيد من المعلومات...',

      // N
      'new_user' : 'مستخدم جديد',
      'next_session' : 'الجلسة القادمة',
      'no_books_found' : 'لا توجد كتب هنا بعد',

      // O
      'offers' : 'العروض',

      // P
      'password' : 'كلمة السر',
      'personal_info' : 'المعلومات الشخصية',
      'participants' : 'المشتركون',
      'price' : 'السعر',
      'phone_number' : 'رقم الهاتف',
      'press_to_reivew_book' : 'اضغط هنا لإضافة تقييم',
      'press_item_to_edit' : 'اضغط على عنصر لتعديله',
      'priority_score' : 'حالة الأولوية',
      'priority_score_obscured' : 'وضع الأولوية محجوب',
      'priority_score_high' : 'مرتفعة',
      'priority_score_low' : 'متدنية',
      'priority_score_mid' : 'متوسطة',

      // S
      'save' : 'حفظ',
      'saved' : 'المحفوظة',
      'search' : 'بحث',
      'search_author_hint': 'أدخل اسم كاتب...',
      'search_book_hint': 'أدخل عنوان كتاب...',
      'session_duration' : 'مدة الجلسة',
      'sham_sign_in' : 'أو عن طريق حساب شام',
      'sign_in' : 'تسجيل الدخول',
      'sign_in_description' : 'سيتيح لك إنشاء حساب على التطبيق القيام بعمليات شراء الكتب أو حجز مكان في نوادي الكتاب من منزلك بالإضافة إلى ميزات أخرى كثيرة!',
      'sign_in_or_create_new_account' : 'إنشاء حساب جديد أو تسجيل الدخول',
      'sign_up' : 'إنشاء حساب',
      'similar_books' : 'كتب مشابهة',
      'social_sign_in' : 'تسجيل الدخول عن طريق',
      'special_categories' : 'التصنيفات المميزة',
      'submit' : 'تأكيد',

      // R
      'rating' : 'التقييم',
      'remove_all' : 'إزالة الكل',
      'reserve_book' : 'احجز الكتاب',
      'reserve_book_request_high_priority' : 'لأنك لديك مجموع نقاط أولوية مرتفع فسوف تستطيع حجز نسخة من الكتاب لمدة',
      'reserve_book_request_medium_priority' : 'لديك مجموع نقاط أولوية متوسط، لذلك تستطيع حجز نسخة من الكتاب لمدة',
      'reserve_book_request_low_priority' : 'عذراً، ليس بإمكانك أن تحجز كتاباً لأن مجموع نقاط الأولوية لديك منخفض',
      'reserve_book_request_submitted' : 'تم إرسال طلبك',
      'review' : 'تقييم',

      // T
      'text_is_empty' : 'لقد أدخلت نصاً فارغاً',
      'title' : 'مكتبة شام',
      'to' : 'إلى',
      'to_learn_more_about_priority' : 'اضغط على "نقاط الأولوية" أدناه لتعرف المزيد عن نقاط الأولوية',

      // U
      'use_app_without_account' : 'متابعة استخدام التطبيق دون حساب',
      'user_profile' : 'ملف المستخدم',
      'username' : 'اسم المستخدم',

      // V
      'view_list' : 'استعراض القائمة',
      'view_more' : 'استعراض المزيد',

    }
  };

  String getValue(String key) {
    return _localizedValues[locale.languageCode][key];
  }

  //// Used when determining the direction of a layout
  TextDirection getDirection() {
    return locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;
  }

  bool isRightToLeft() {
    return getDirection() == TextDirection.rtl;
  }
}

class ShamLocalizationsDelegate extends LocalizationsDelegate<ShamLocalizations> {
  const ShamLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<ShamLocalizations> load(Locale locale) {
    return SynchronousFuture<ShamLocalizations>(ShamLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<ShamLocalizations> old) => false;

}