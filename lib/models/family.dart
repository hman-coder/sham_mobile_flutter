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

  static final Family mock = Family(
    parents: [
      FamilyMember(
          image:
          'https://linktopin.com/assets/images/avatars/random-avatar1.jpg',
          name: 'John Smith',
          title: 'father'.tr,
      ),
      FamilyMember(
          image:
          'https://linktopin.com/assets/images/avatars/random-avatar8.jpg',
          name: 'Sara Smith',
          title: 'mother'.tr),
    ],
    children: [
      FamilyMember(
          image:
          'https://linktopin.com/assets/images/avatars/random-avatar7.jpg',
          name: 'John Smith Jr.',
          title: '12 ' + 'years_old'.tr),
      FamilyMember(
          image:
          'https://cdn1.iconfinder.com/data/icons/children-avatar-flat/128/children_avatar-16-512.png',
          name: 'Samantha Smith',
          title: '9 ' + 'years_old'.tr),
      FamilyMember(
          image:
          'https://www.shareicon.net/data/128x128/2016/06/25/786530_people_512x512.png',
          name: 'محمد سميث',
          title: '4 ' + 'years_old'.tr),
    ],
    familyName: 'العائلة الملكية',
    code: '67483',
  );
}