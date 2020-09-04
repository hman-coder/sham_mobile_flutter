import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class ActivitiesUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(ShamLocalizations.of(context).getValue('activities')),
        ),
        body: Center(child: Text('Activities')));
  }
}