import 'package:flutter/foundation.dart';
import 'package:sham_mobile/helpers/string_helper.dart';

import 'gender.dart';

class FamilyMember {
  final String name;

  final String title;

  final String image;

  final Gender gender;

  FamilyMember({
    this.gender = Gender.undefined,
    this.image = '',
    @required this.name,
    @required this.title,
  });

  const FamilyMember.nonNull()
      : this.name = '',
        this.image = '',
        this.title = '',
        this.gender = null;

  FamilyMember copyWith({String image, String name, String title}) {
    return FamilyMember(
      image: image ?? this.image,
      name: name ?? this.name,
      title: title ?? this.title,
    );
  }
}

class Child extends FamilyMember {
  final DateTime birthday;

  Child({String image = '', @required String name, this.birthday})
      : super(
          image: image,
          name: name,
          title: birthday == null
              ? ''
              : (DateTime.now().year - birthday.year).toString(),
        );

  const Child.nonNull()
      : this.birthday = null,
        super.nonNull();
}
