import 'age_group.dart';

class Activity {
  String title;

  String image;

  String description;

  AgeGroup ageGroup;

  String frequency;

  double price;

  bool ended;

  bool isBookClub;

  String duration;

  DateTime nextSession;

  int participants;

  int slots;

  Activity({this.title, this.description, this.ageGroup, this.frequency,
    this.price, this.ended, this.isBookClub, this.nextSession, this.image, this.duration,
    this.participants, this.slots});
}

class Session {

}