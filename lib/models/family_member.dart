import 'package:flutter/foundation.dart';

import 'gender.dart';

abstract class FamilyMember {
  final String name;

  final String image;

  final Gender gender;

  const FamilyMember({this.name, this.image, this.gender});

  const FamilyMember.nonNull()
      : name = '',
        image = '',
        gender = null;

  String get title;
}

class Parent extends FamilyMember {
  final String title;

  const Parent({
    gender = Gender.undefined,
    image = '',
    String name,
    this.title,
  }) : super(name: name, image: image, gender: gender);

  const Parent.nonNull()
      : title = '',
        super.nonNull();

  Parent copyWith({String image, String name, String title, Gender gender}) {
    return Parent(
      image: image ?? this.image,
      name: name ?? this.name,
      title: title ?? this.title,
      gender: this.gender,
    );
  }
}

class Child extends FamilyMember {
  final DateTime birthday;

  Child({String image = '', @required String name, this.birthday})
      : super(
          image: image,
          name: name,
        );

  const Child.nonNull()
      : this.birthday = null,
        super.nonNull();

  @override
  String get title => birthday == null ? '' : (DateTime.now().year - birthday.year).toString();
}
