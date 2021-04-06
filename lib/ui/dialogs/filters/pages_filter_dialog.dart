import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/message_controller.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/ui/widgets/activatable_widget.dart';
import 'package:sham_mobile/ui/widgets/number_spinner.dart';

class PagesDialog extends StatefulWidget {
  final int upperBound;

  final int lowerBound;

  const PagesDialog({Key key, this.upperBound = -1, this.lowerBound = -1}) : super(key: key);

  @override
  _PagesDialogState createState() => _PagesDialogState();
}

class _PagesDialogState extends State<PagesDialog> {
  bool isActivated;

  int upperBound;

  int lowerBound;

  @override
  void initState() {
    upperBound = widget.upperBound;
    lowerBound = widget.lowerBound;

    if(lowerBound < 0) {
      lowerBound = 0;
      upperBound = 100;
    }

    isActivated = widget.upperBound > -1;

    super.initState();
  }

  bool get boundsAreCorrect => lowerBound < upperBound;

  switchActivation() => setState(() => isActivated = ! isActivated);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: Get.direction,
        child: AlertDialog(
          title: Text("rating".tr),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CheckboxListTile(
                  onChanged: (value) => switchActivation(),
                  value: isActivated,
                  title: Text('activate'.tr),
                ),

                ActivatableWidget(
                    isActive: isActivated,
                    child: Text('from'.tr,)
                ),

                SizedBox(height: 15),

                ActivatableWidget(
                  isActive: isActivated,
                  child: NumberSpinner(
                    minValue: 0,
                    maxValue: 1000000,
                    onValueChanged: (value) => lowerBound = value.toInt(),
                    initialValue: lowerBound.toDouble(),
                    incrementValue: 25,
                  ),
                ),

                SizedBox(height: 15),

                ActivatableWidget(
                    isActive: isActivated,
                    child: Text('to'.tr,)
                ),

                SizedBox(height: 15),

                ActivatableWidget(
                  isActive: isActivated,
                  child: NumberSpinner(
                    minValue: 0,
                    maxValue: 1000000,
                    onValueChanged: (value) => upperBound = value.toInt(),
                    initialValue: upperBound.toDouble(),
                    incrementValue: 25,
                  ),
                ),
              ],
            ),
          ),

          actions: <Widget>[
            FlatButton(
              child: Text("cancel".tr),
              onPressed: () => Get.back(),
            ),

            FlatButton(
              child: Text("accept".tr),
              onPressed: onAccept,
            ),
          ],
        )
    );
  }

  void onAccept() {
    List<int> result = [lowerBound, upperBound];
    if(! isActivated) {
      result = [-1, -1];

    } else if (lowerBound == upperBound) {
      Get.find<ShamMessageController>().showMessage(
          ShamMessage(
              severity: MessageSeverity.mild,
              message: 'values_should_be_unequal'.tr,
              displayType: MessageDisplayType.snackbar
          )
      );

      return;

    } else if(upperBound < lowerBound) {
      result = [upperBound, lowerBound];
    }
    Get.back(result: result);
  }
}
