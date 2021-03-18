import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';

class RatingsDialog extends StatefulWidget {
  final double upperBound;

  final double lowerBound;

  RatingsDialog({Key key, @required this.upperBound, @required this.lowerBound, }) : super(key: key);

  @override
  _RatingsDialogState createState() => _RatingsDialogState();
}

class _RatingsDialogState extends State<RatingsDialog> {
  double newLowerBound;

  double newUpperBound;

  bool isActivated;

  @override
  void initState() {
    newUpperBound = widget.upperBound;
    newLowerBound = widget.lowerBound;

    if(newLowerBound < 0) {
      newLowerBound = 1;
      newUpperBound = 2;
    }

    isActivated = widget.upperBound > -1;

    super.initState();
  }

  bool get boundsAreCorrect => newLowerBound < newUpperBound;

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

                Text('from'.tr, style: TextStyle(color: isActivated ? Colors.black : Colors.grey)),

                RatingBar.builder(
                  initialRating: newLowerBound,
                  onRatingUpdate: isActivated ? onLowerBoundChanged : null,
                  itemBuilder: (context, index) =>
                      Icon(
                          Icons.star,
                          color: isActivated ? Colors.amber : Colors.grey
                      ),
                ),

                Text('to'.tr, style: TextStyle(color: isActivated ? Colors.black : Colors.grey)),

                RatingBar.builder(
                  initialRating: newUpperBound,
                  onRatingUpdate: isActivated ? onUpperBoundChanged : null,
                  itemBuilder: (context, index) =>
                      Icon(
                          Icons.star,
                          color: isActivated ? Colors.amber : Colors.grey
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

  void onLowerBoundChanged(double value) {
    setState(() => newLowerBound = value);
  }

  void onUpperBoundChanged(double value) {
    setState(() => newUpperBound = value);
  }

  void onAccept() {
    List<double> result = [newLowerBound, newUpperBound];
    if(! isActivated) {
      result = [-1, -1];

    } else if (newUpperBound == newLowerBound) {
      Get.find<ShamMessageController>().showMessage(
          ShamMessage(
              severity: MessageSeverity.mild,
              message: 'values_should_be_unequal'.tr,
              displayType: MessageDisplayType.snackbar
          )
      );

      return;

    } else if(newUpperBound < newLowerBound) {
      result = [newUpperBound, newLowerBound];
    }
    Get.back(result: result);
  }
}