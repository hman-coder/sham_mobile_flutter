import 'package:flutter/material.dart';
import 'package:sham_mobile/providers/sham_localizations.dart';

class ErrorHeaderTextWidget extends StatelessWidget {
  final String header;

  const ErrorHeaderTextWidget( this.header, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: ShamLocalizations.of(context).getDirection(),
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
        textDirection: ShamLocalizations.of(context).getDirection(),
        child: Text(
          message,
          style: TextStyle(
              color: Colors.white
          ),
        )
    );
  }
}

