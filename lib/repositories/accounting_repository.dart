import 'package:sham_mobile/models/purchase_record.dart';

class AccountingRepository {
  Future<List<PurchaseRecord>> fetchPurchaseRecords(int userId) async {
    await Future.delayed(Duration(milliseconds: 1500));
    return _mockPurchaseRecords;
  }

  List<PurchaseRecord> get _mockPurchaseRecords {
    return [
      PurchaseRecord(
        itemName: 'قصة مدينتين',
        itemType: PurchaseRecordType.book,
        purchaseMadeBy: 'هشام',
        dateTime: DateTime(2020,11,4),
        payment: 5000,
      ),
      PurchaseRecord(
        itemName: 'نادي كتاب للأطفال',
        itemType: PurchaseRecordType.book_club,
        purchaseMadeBy: 'هشام',
        dateTime: DateTime(2021,1,14),
        payment: 4000,
      ),
      PurchaseRecord(
        itemName: 'محاضرة عن الكورونا',
        itemType: PurchaseRecordType.activity,
        purchaseMadeBy: 'الحرمة',
        dateTime: DateTime(2021,1,19),
        payment: 10000,
      ),
      PurchaseRecord(
        itemName: 'صورة دوريان غراي',
        itemType: PurchaseRecordType.book,
        purchaseMadeBy: 'هشام',
        dateTime: DateTime(2021,2,1),
        payment: 6700,
      ),
      PurchaseRecord(
        itemName: 'قصة مدينتين',
        itemType: PurchaseRecordType.book,
        purchaseMadeBy: 'هشام',
        dateTime: DateTime(2020,11,4),
        payment: 5000,
      ),
      PurchaseRecord(
        itemName: 'نادي كتاب للأطفال',
        itemType: PurchaseRecordType.book_club,
        purchaseMadeBy: 'هشام',
        dateTime: DateTime(2021,1,14),
        payment: 4000,
      ),
      PurchaseRecord(
        itemName: 'محاضرة عن الكورونا',
        itemType: PurchaseRecordType.activity,
        purchaseMadeBy: 'الحرمة',
        dateTime: DateTime(2021,1,19),
        payment: 10000,
      ),
      PurchaseRecord(
        itemName: 'صورة دوريان غراي',
        itemType: PurchaseRecordType.book,
        purchaseMadeBy: 'هشام',
        dateTime: DateTime(2021,2,1),
        payment: 6700,
      ),
    ];
  }
}
