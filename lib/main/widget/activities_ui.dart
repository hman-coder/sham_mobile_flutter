import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class ActivitiesUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(ShamLocalizations.getString(context, 'activities')),
        ),
        body: Center(child: Text('Activities')));
  }
}