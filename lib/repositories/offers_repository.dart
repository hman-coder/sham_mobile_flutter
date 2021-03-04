import 'package:sham_mobile/models/offer.dart';

class OffersRepository {
  List<Offer> fetchOffers([int initialIndex = 0]) {
    return [
      Offer(
        title: 'عرض على الكتب',
        description:
            'عرض خاص! عند شرائك 3 كتب من التطبيق ستحصل على كتاب مجاناً!',
        destination: 'books',
        destinationId: -1,
        image: "assets/images/12_rules.jpg",
      ),
      Offer(
        title: 'ندوة للأطفال',
        description:
            'بمناسبة عيد ميلاد المكتبة ستقيم المكتبة ندوة بعنوان "أعياد الميلاد - ليش حرام؟". ملاحظة: يُرجى إحضار الأطفال الذين تودون معاقبتهم حصراً.',
        destination: 'activities',
        destinationId: -1,
        image: "assets/images/blind_date_3.jpg",
      ),
      Offer(
        title: 'جلسة تعريفية',
        description:
            'جلسة تعريفية للدورة الجديدة لفئة اليافعين! التسجيل لهذه الجلسة مجاني بالكامل',
        destination: 'book_clubs',
        destinationId: -1,
        image: "assets/images/sham_bag.jpg",
      ),
      Offer(
        title: 'فيلم كرتون',
        description:
            'للأطفال فقط! جلسة لمشاهدة فيلم كرتون ومناقشته مع كبار العلماء والأئمة. اضغط هنا للتسجيل',
        destination: 'activities',
        destinationId: -1,
        image: "assets/images/sham_books_1.jpg"),
    ];
  }
}
