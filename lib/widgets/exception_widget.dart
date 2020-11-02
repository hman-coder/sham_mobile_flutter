import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class ExceptionWidget extends StatefulWidget {
  final String text;

  const ExceptionWidget({Key key, this.text}) : super(key: key);

  @override
  _ExceptionWidgetState createState() => _ExceptionWidgetState();
}

class _ExceptionWidgetState extends State<ExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("${widget.text} ${ShamLocalizations.getString(context, 'error_report_message')}"),
            FlatButton(
              onPressed: () => print("Error reported"),
              child: Text(ShamLocalizations.getString(context, 'error_report_button')),
            )
          ],
        )
    );
  }
}
