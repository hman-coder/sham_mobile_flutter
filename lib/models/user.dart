import 'family.dart';

class User {
  // Static/Current user

  static User _instance;

  static User get singleton {
    if (_instance == null) buildTestUser();
    return _instance;
  }

  static buildTestUser() {
    _instance = User(
      image: "assets/images/hisham.png",
      username: 'هشام صديق',
      id: 2,
      priorityPoints: 60,
      phoneNumber: "0988888888",
      address: "الميريديان - شارع ورد شان - بناية البطيخ المبسمر",
      family: Family(id: 10, name: "عائلة هشام صديق يا ويلي"),
      birthday: DateTime(1991, 9, 29),
    );
  }

  // Model

  String username;
  String password;
  String token;
  String image;
  String phoneNumber;
  String address;
  int priorityPoints;
  DateTime birthday;
  int id;
  Family family;

  User({this.username, this.password, this.token, this.image, this.id, this.priorityPoints, this.phoneNumber, this.address, this.family, this.birthday});

  bool get isLowPrio => priorityPoints < 50;

  bool get isMidPrio => priorityPoints >= 50 && priorityPoints < 100;

  bool get isHighPrio => priorityPoints >= 100;

  @override
  bool operator ==(other) {
    if(!(other is User)) return false;
    return this.id == other.id;
  }

  /// Checks whether this user's personal info can be accessed
  /// by the given [user].
  bool canAccessInfo(User user) {
    return this.family?.id == user.family?.id;
  }


}