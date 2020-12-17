import 'address.dart';
import 'book_list.dart';
import 'gender.dart';

class User {

  static User buildTestUser() {
    return User(
      image: "assets/images/hisham.png",
      username: 'هشام صديق',
      id: 2,
      priorityPoints: 60,
      phoneNumber: "0988888888",
      address: Address(
        city: 'aleppo',
        district: 'الفرقان',
        street: 'شارع الإكسبريس',
        others: 'بناء مازن الباشا، جانب أورانج كيك'
      ),
      // family: Family(id: 10, name: "عائلة هشام صديق يا ويلي"),
      birthday: DateTime(1991, 9, 29),
    );
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      birthday: DateTime.parse(json['birthday']),
      id: json['id'],
      facebookAccessToken: json['facebook_access_token'],
      googleAccessToken: json['google_access_token'],
      image: json['image_url'],
      priorityPoints: json['priority_points'],
    );
  }
  // Model

  String username;
  String firstName;
  String lastName;
  String password;
  String image;
  String phoneNumber;
  Address address;
  String facebookAccessToken;
  String googleAccessToken;
  int priorityPoints;
  DateTime birthday;
  int id;
  String email;
  List<BookList> bookLists;
  Gender gender;

  User(
      {this.username,
      this.firstName,
      this.lastName,
      this.password,
      this.email,
      this.image,
      this.id,
      this.facebookAccessToken,
      this.googleAccessToken,
      this.priorityPoints,
      this.phoneNumber,
      this.address,
      this.birthday,
      this.gender,
      this.bookLists = const []
      });

  bool get isLowPrio => priorityPoints < 50;

  bool get isMidPrio => priorityPoints >= 50 && priorityPoints < 100;

  bool get isHighPrio => priorityPoints >= 100;

  @override
  bool operator ==(other) {
    if (!(other is User)) return false;
    return this.id == other.id;
  }

  /// Checks whether this user's personal info can be accessed
  /// by the given [user].
  bool canAccessInfo(User user) {
    // return this.family?.id == user.family?.id;
    return true;
  }

  @override
  String toString() {
    return 'User{'
        'first name: $firstName \n'
        'last_name: $lastName; \n'
        'birthday: $birthday; \n'
        'phone number: $phoneNumber; \n'
        'address: ${address?.summary}; \n'
        'gender: $gender; \n'
        'facebook AT: $facebookAccessToken; \n'
        'google AT: $googleAccessToken, \n'
        '}';
  }

  String get fullName => '$firstName $lastName';
}
