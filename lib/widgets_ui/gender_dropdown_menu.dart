import 'package:flutter/material.dart';
import 'package:sham_mobile/models/gender.dart';
import 'package:get/utils.dart';

/// A dropdown menu to select gender
class GenderDropdownMenu extends StatelessWidget {
  final Function(Gender) onGenderChanged;

  final Gender currentValue;

  final bool isExpanded;

  /// The text that appears when no value is selected
  final String noSelectionText;

  const GenderDropdownMenu({
    Key key,
    @required this.onGenderChanged,
    this.currentValue,
    this.isExpanded = false,
    @required this.noSelectionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Gender>(
      underline: const SizedBox(),
      items: Gender.values
          .map<DropdownMenuItem<Gender>>(
            (gender) => DropdownMenuItem(
              child: Text(gender.toTranslationString().tr),
              value: gender,
            ),
          )
          .toList()
            ..add(
              DropdownMenuItem<Gender>(
                child: Text(noSelectionText),
                value: null,
              ),
            ),
      onChanged: onGenderChanged,
      value: currentValue,
      isExpanded: isExpanded,
    );
  }
}
