import 'package:flutter/material.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/dynamic_values/dynamic_values_repository.dart';
import 'package:sham_mobile/user/user_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

/// Provides constant values based on app changes such as
/// user priority score changes.
class DynamicValuesBloc {
  DynamicValuesRepository _repo;

  DynamicValuesBloc() :
        _repo = DynamicValuesRepository();

  String _getReserveBookDays(BuildContext context) {
    int priorityPoints = context.bloc<UserBloc>().user.priorityPoints;
    if(priorityPoints < 50) {
      return _repo.lowPrioBookDays;
    } else if(priorityPoints < 100) {
      return _repo.medPrioBookDays;
    } else {
      return _repo.highPrioBookDays;
    }
  }

  String _getReserveBookMessage(int priorityPoints) {
    if(priorityPoints < 50) {
      return 'reserve_book_request_low_priority'.tr;
    } else if(priorityPoints < 100) {
      return 'reserve_book_request_medium_priority'.tr;
    } else {
      return 'reserve_book_request_high_priority'.tr;
    }
  }

  String getReserveBookMessage(BuildContext context, double bookPrice) {
    int priorityPoints = User.buildTestUser().priorityPoints;

    String returnedString = "${_getReserveBookMessage(priorityPoints)}";
    if(userCanReserveBook(context)) {
      returnedString += " ${_getReserveBookDays(context)}."
          "${"claim_book".tr}.\n"
          "${"price".tr}: ${bookPrice.round()}.\n\n";
    } else {
      returnedString += ".\n\n";
    }

    returnedString += "${"to_learn_more_about_priority".tr}.";

    return returnedString;
  }

  bool userCanReserveBook(BuildContext context) => context.bloc<UserBloc>().user.priorityPoints >= 50;
}