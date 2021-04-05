import 'package:get/get_utils/get_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:sham_mobile/models/family_member.dart';

class Family {
  final List<FamilyMember> parents;

  final List<FamilyMember> children;

  final String familyName;

  final String code;

  const Family({
    @required this.parents,
    @required this.children,
    @required this.familyName,
    @required this.code,
  });

  Family copyWith({
    List<FamilyMember> parents,
    List<FamilyMember> children,
    String familyName,
    String code,
  }) {
    return Family(
      parents: parents ?? this.parents,
      children: children ?? this.children,
      familyName: familyName ?? this.familyName,
      code: code ?? this.code,
    );
  }

  static final Family mock = Family(
    parents: [
      Parent(
          image:
          'https://linktopin.com/assets/images/avatars/random-avatar1.jpg',
          name: 'John Smith',
          title: 'father'.tr,
      ),
      Parent(
          image:
          'https://linktopin.com/assets/images/avatars/random-avatar8.jpg',
          name: 'Sara Smith',
          title: 'mother'.tr),
    ],
    children: [
      Child(
          image:
          'https://linktopin.com/assets/images/avatars/random-avatar7.jpg',
          name: 'John Smith Jr.',
          birthday: DateTime(2010)),
      Child(
          image:
          'https://cdn1.iconfinder.com/data/icons/children-avatar-flat/128/children_avatar-16-512.png',
          name: 'Samantha Smith',
          birthday: DateTime(2019)),
      Child(
          image:
          'https://www.shareicon.net/data/128x128/2016/06/25/786530_people_512x512.png',
          name: 'محمد سميث',
          birthday: DateTime(2015)),
    ],
    familyName: 'العائلة الملكية',
    code: '674830',
  );
}