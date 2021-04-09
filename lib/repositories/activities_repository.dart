import 'package:sham_mobile/barrels/book_barrel.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/constants/paths.dart';

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
      image: '${kpAssetImages}blind_date_1.jpg',
    ),

    Activity(
      title: 'محاضرة عن المشاريع الخاصة',
      ageGroup: AgeGroup.adults(),
      duration: 'ساعة واحدة',
      image: '${kpAssetImages}group_reading.jpg',
    ),

    Activity(
      title: 'دورة خط عربي',
      ageGroup: AgeGroup.kids(),
      duration: 'شهر واحد',
      nextSession: DateTime(2021, 2, 15),
      image: '${kpAssetImages}sham_bag.jpg',
    ),

    Activity(
      title: 'اجتماع لأهالي الأطفال',
      ageGroup: AgeGroup.kids(),
      duration: 'شهر واحد',
      nextSession: DateTime(2021, 2, 15),
      image: '${kpAssetImages}family_reading.jpg',
    ),
  ];
}