import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/constants/locales.dart';
import 'package:sham_mobile/ui/widgets/buttons/cancel_button.dart';
import 'package:sham_mobile/constants/default_widgets.dart';
import 'package:sham_mobile/constants/default_values.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';

class ChangeLanguageDialog extends StatefulWidget {
  @override
  _ChangeLanguageDialogState createState() => _ChangeLanguageDialogState();
}

class _ChangeLanguageDialogState extends State<ChangeLanguageDialog> {
  Locale locale;

  @override
  void initState() {
    locale = Get.locale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: AlertDialog(
        title: Text('change_language'.tr),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Locale>(
                isExpanded: true,
                value: locale,
                onChanged: (value) => setState(() => locale = value),
                items: supportedLocales
                    .map<DropdownMenuItem<Locale>>(
                      (e) => DropdownMenuItem<Locale>(
                        value: e,
                        child: Text(
                          '${e.toString().tr} (${e.toString()})',
                        ),
                      ),
                    )
                    .toList(),
              ),
              verticalSmallSpacer,
              if (localeChanged)
                Row(
                  children: [
                    Text(
                      'restart_required_for_this_action'.tr + '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: ktsExtraSmallTextSize,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          CancelButton(),
          FlatButton(
            onPressed: () {
              if (localeChanged) {
                Get.locale = this.locale;
                Get.offAllNamed('/loading');
              }
            },
            child: Text('confirm'.tr),
          ),
        ],
      ),
    );
  }

  bool get localeChanged => Get.locale != this.locale;
}
