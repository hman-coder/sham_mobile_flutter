import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class FamilyInfoUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(ShamLocalizations.of(context).getValue('family_info')),
        ),
        body: Center(child: Text('Family Info')));
  }
}