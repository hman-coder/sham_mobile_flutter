import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sham_mobile/constants/sham_custom_icons.dart';

class PurchaseRecord {
  final DateTime dateTime;

  /// The item type for which the user has paid
  final PurchaseRecordType itemType;

  /// The name/title of the purchased item. For example: The Tale of Two Cities
  final String itemName;

  /// The person who made the purchase. Could be either parent
  final String purchaseMadeBy;

  /// If the purchase was made for a child, their name should be mentioned here.
  final String purchaseMadeForFamilyMember;

  final double payment;

  const PurchaseRecord({
    @required this.itemName,
    @required this.itemType,
    @required this.purchaseMadeBy,
    this.purchaseMadeForFamilyMember = '-',
    @required this.dateTime,
    @required this.payment,
  });

  String get purchasedItemFullInfo => itemType.toString().tr;
}

/// The item type for which the user has paid
enum PurchaseRecordType {
  book_club,
  activity,
  book,
}

extension PurchaseRecordTypeExtensions on PurchaseRecordType{
  IconData get icon {
    switch(this) {
      case PurchaseRecordType.book_club:
        return ShamCustomIcons.book_club;

      case PurchaseRecordType.activity:
        return ShamCustomIcons.activity;

      case PurchaseRecordType.book:
        return ShamCustomIcons.book_stack;

      default:
        return null;
    }
  }

  String get translatedName {
    switch(this) {
      case PurchaseRecordType.book_club:
        return 'book_club'.tr;

      case PurchaseRecordType.activity:
        return 'activity'.tr;

      case PurchaseRecordType.book:
        return 'book'.tr;

      default:
        return null;
    }
  }
}