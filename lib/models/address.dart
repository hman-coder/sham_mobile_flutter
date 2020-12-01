import 'package:get/get_utils/get_utils.dart';

class Address {
  String city;

  String district;

  String street;

  String others;

  Address({this.city, this.district, this.street, this.others});

  String get summary =>
      (city != null ? city + 'comma'.tr + ' ' : '') // 'city, '
          + (district != null ? district + 'comma'.tr + ' ' : '')
          + (street != null ? street + 'comma'.tr + ' ' : '')
          + (others != null ? others + 'comma'.tr + ' ' : '');
}