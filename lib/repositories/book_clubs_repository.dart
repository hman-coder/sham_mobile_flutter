import 'package:flutter/cupertino.dart';
import 'package:sham_mobile/models/activity.dart';
import 'package:sham_mobile/models/age_group.dart';

class BookClubsRepository extends ChangeNotifier {
  List<Activity> get bookClubs {
    return [
      Activity(
        title: "نادي كتاب لليافعين",
        ageGroup: AgeGroup.adolescents(),
        description: "نادي كتاب ندرس فيه العديد من الكتب التي تؤثر إيجابا على الفئة العمرية المحددة وتساعدهم في النمو وتعلم أشياء جديدة عن الحياة",
        ended: false,
        frequency: "كل 10 أيام",
        isBookClub: true,
        price: 5000,
        nextSession: DateTime(2020, 7, 30),
        image: 'assets/images/group_reading.jpg',
        duration: '90 دقيقة',
        participants: 2,
        slots: 10,
      ),

      Activity(
        title: "نادي كتاب للبالغين",
        ageGroup: AgeGroup.adults(),
        description: "نادي كتاب ندرس فيه العديد من الكتب التي تؤثر إيجابا على الفئة العمرية المحددة وتساعدهم في النمو وتعلم أشياء جديدة عن الحياة",
        ended: false,
        frequency: "كل أسبوع",
        isBookClub: true,
        price: 8000,
        nextSession: DateTime(2020, 8, 1),
        image: 'assets/images/family_reading.jpg',
        duration: '90 دقيقة',
        participants: 10,
        slots: 10,
      ),

      Activity(
        title: "نادي كتاب للمسنين",
        ageGroup: AgeGroup.aged(),
        description: "نادي كتاب ندرس فيه العديد من الكتب التي تؤثر إيجابا على الفئة العمرية المحددة وتساعدهم في النمو وتعلم أشياء جديدة عن الحياة",
        ended: false,
        frequency: "اليوم الثاني من كل شهر",
        isBookClub: true,
        price: 10000,
        nextSession: DateTime(2020, 8, 10),
        image: 'assets/images/aged_reading.jpg',
        duration: '90 دقيقة',
        participants: 8,
        slots: 10,
      ),
      Activity(
        title: "نادي كتاب لليافعين 2",
        ageGroup: AgeGroup.adolescents(),
        description: "نادي كتاب ندرس فيه العديد من الكتب التي تؤثر إيجابا على الفئة العمرية المحددة وتساعدهم في النمو وتعلم أشياء جديدة عن الحياة",
        ended: false,
        frequency: "كل جمعة",
        isBookClub: true,
        price: 50000,
        nextSession: DateTime(2020, 9, 1),
        image: 'assets/images/group_reading.jpg',
        duration: '90 دقيقة',
        participants: 7,
        slots: 10,
      ),

      Activity(
        title: "نادي كتاب لمتوسطي العمر",
        ageGroup: AgeGroup.midLife(),
        description: "نادي كتاب ندرس فيه العديد من الكتب التي تؤثر إيجابا على الفئة العمرية المحددة وتساعدهم في النمو وتعلم أشياء جديدة عن الحياة",
        ended: true,
        frequency: "كل 10 أيام",
        isBookClub: true,
        price: 50000,
        nextSession: DateTime(2020, 9, 3),
        image: 'assets/images/adult_reading.jpg',
        duration: '90 دقيقة',
        participants: 8,
        slots: 10,
      )
    ];
  }
}