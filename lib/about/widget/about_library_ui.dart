import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class AboutLibraryUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(ShamLocalizations.getString(context, 'about_sham')),
        ),
        body: Center(child: Text('About Sham')));
  }

}