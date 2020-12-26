import 'package:sham_mobile/models/blind_date.dart';

class BlindDatesRepository {
  get blindDates => [
    BlindDate(
      bookId: 1,
      description: "شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى",
      image: "assets/images/blind_date_1.jpg",
    ),
    BlindDate(
      bookId: 2,
      description: "شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى",
      image: "assets/images/blind_date_2.jpg",
    ),
    BlindDate(
      bookId: 3,
      description: "شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى شرح موعد أعمى وصف موعد أعمى",
      image: "assets/images/blind_date_3.jpg",
    )
  ];

  Future<List<BlindDate>> fetchBlindDates({int startingIndex = 0}) async {
    return blindDates;
  }
}