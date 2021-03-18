import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

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
            Text("${widget.text} ${'error_report_message'.tr}"),
            FlatButton(
              onPressed: () => print("Error reported"),
              child: Text('error_report_button'.tr),
            )
          ],
        )
    );
  }
}
