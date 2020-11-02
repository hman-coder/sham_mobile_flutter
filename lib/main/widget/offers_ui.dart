import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class OffersUI extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(ShamLocalizations.getString(context, 'offers')),
        ),
        body: Center(child: Text('offers')));
  }
}