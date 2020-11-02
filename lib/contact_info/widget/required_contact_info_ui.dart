import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class RequiredContactInfoUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('required info'),

          CheckboxListTile(
            title: Text(ShamLocalizations.getString(context, "phone_number")),
            subtitle: Text(ShamLocalizations.getString(context, "phone_number_description")),
            value: true,
            onChanged: null
          ),

          CheckboxListTile(
            title: Text(ShamLocalizations.getString(context, "personal_info")),
            subtitle: Text(ShamLocalizations.getString(context, "personal_info_description")),
            value: true,
            onChanged: null,
          ),

          CheckboxListTile(
              title: Text(ShamLocalizations.getString(context, "personal_info")),
              subtitle: Text(ShamLocalizations.getString(context, "personal_info_description")),
              value: true,
              onChanged: null,
          ),
        ]
      ),
    );
  }
}
