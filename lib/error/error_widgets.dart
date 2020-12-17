import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/widgets/default_values.dart';


class ErrorHeaderTextWidget extends StatelessWidget {
  final String header;

  const ErrorHeaderTextWidget( this.header, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: Get.direction,
        child: Text(
          header,
          style: TextStyle(
            color: Colors.white
          ),
        )
    );
  }
}

class ErrorMessageTextWidget extends StatelessWidget {
  final String message;

  const ErrorMessageTextWidget(this.message, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: Get.direction,
        child: Text(
          message,
          style: TextStyle(
              color: Colors.white
          ),
        )
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  final String title;

  final String message;

  const ConfirmationDialog({
    Key key,
    @required this.title,
    @required this.message})
      : assert(title != null && message != null, 'You must provide both title and message'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(fontSize: DefaultValues.largeTextSize )),
      content: Text(message),
      actions: [
        FlatButton(
          child: Text('cancel'.tr),
          onPressed: () => Get.back(result: false),
        ),
        FlatButton(
          child: Text('confirm'.tr),
          onPressed: () => Get.back(result: true),
        )
      ],
    );
  }
}
