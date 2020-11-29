import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';


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

