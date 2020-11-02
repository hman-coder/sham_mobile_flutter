import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class AccountInfoUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(ShamLocalizations.getString(context, 'account')),
        ),
        body: Center(child: Text('Account Info')));
  }
}