import 'package:flutter/material.dart';
import 'package:sham_mobile/models/user.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';
import 'package:sham_mobile/repositories/dynamic_values_repository.dart';

/// Provides constant values based on app changes such as
/// user priority score changes.
class DynamicValuesBloc {
  DynamicValuesRepository _repo;

  DynamicValuesBloc() : _repo = DynamicValuesRepository();

  String _getReserveBookDays(BuildContext context) {
    int priorityPoints = User.singleton.priorityPoints;
    if(priorityPoints < 50) {
      return _repo.lowPrioBookDays;
    } else if(priorityPoints < 100) {
      return _repo.medPrioBookDays;
    } else {
      return _repo.highPrioBookDays;
    }
  }

  String _getReserveBookMessage(ShamLocalizations localizations, int priorityPoints) {
    if(priorityPoints < 50) {
      return localizations.getValue('reserve_book_request_low_priority');
    } else if(priorityPoints < 100) {
      return localizations.getValue('reserve_book_request_medium_priority');
    } else {
      return localizations.getValue('reserve_book_request_high_priority');
    }
  }

  String getReserveBookMessage(BuildContext context, double bookPrice) {
    ShamLocalizations localizations = ShamLocalizations.of(context);
    int priorityPoints = User.singleton.priorityPoints;

    String returnedString = "${_getReserveBookMessage(localizations, priorityPoints)}";
    if(userCanReserveBook) {
      returnedString += " ${_getReserveBookDays(context)}."
          "${localizations.getValue("claim_book")}.\n"
          "${localizations.getValue("price")}: ${bookPrice.round()}.\n\n";
    } else {
      returnedString += ".\n\n";
    }

    returnedString += "${localizations.getValue("to_learn_more_about_priority")}.";

    return returnedString;
  }

  bool get userCanReserveBook => User.singleton.priorityPoints >= 50;
}