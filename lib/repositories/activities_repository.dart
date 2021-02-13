import 'package:sham_mobile/book_barrel.dart';
import 'package:sham_mobile/models/activity.dart';

class ActivitiesRepository {
  Future<List<Activity>> fetchActivities([int currentIndex = 0]) async {
    await Future.delayed(Duration(milliseconds: 1500));
    return _mockActivities;
  }

  List<Activity> get _mockActivities => [
    Activity(
      title: 'فيلم وثائقي',
      frequency: 'يوم واحد',
      duration: 'ساعة واحدة',
      ageGroup: AgeGroup.adults(),
      image: 'assets/images/blind_date_1.jpg',
    ),

    Activity(
      title: 'محاضرة عن المشاريع الخاصة',
      ageGroup: AgeGroup.adults(),
      duration: 'ساعة واحدة',
      image: 'assets/images/group_reading.jpg',
      // image: 'assets/images/basic_upside_down.jpg',
    ),

    Activity(
      title: 'دورة خط عربي',
      ageGroup: AgeGroup.kids(),
      duration: 'شهر واحد',
      nextSession: DateTime(2021, 2, 15),
      image: 'assets/images/sham_bag.jpg',
    ),

    Activity(
      title: 'اجتماع لأهالي الأطفال',
      ageGroup: AgeGroup.kids(),
      duration: 'شهر واحد',
      nextSession: DateTime(2021, 2, 15),
      image: 'assets/images/family_reading.jpg',
    ),
  ];
}