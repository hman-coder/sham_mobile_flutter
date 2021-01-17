import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/controllers/error_controller.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';
import 'package:sham_mobile/widgets_ui/activatable_widget.dart';
import 'package:sham_mobile/widgets_ui/number_spinner.dart';

class BookFilterDialog<T> extends StatefulWidget {
  final List<T> allObjects;

  final List<T> initiallySelectedObjects;

  final String title;

  final String Function(T) displayName;

  final bool showSearchField;

  const BookFilterDialog({Key key,
    @required this.allObjects,
    @required this.initiallySelectedObjects,
    @required this.title,
    @required this.displayName,
    this.showSearchField = false, }) : super(key: key);

  @override
  _BookFilterDialogState<T> createState() => _BookFilterDialogState<T>();
}

class _BookFilterDialogState<T> extends State<BookFilterDialog<T>> {
  List<T> displayedObjects;

  List<T> selectedObjects;

  @override
  void initState() {
    selectedObjects = []..addAll(widget.initiallySelectedObjects);
    displayedObjects = widget.allObjects;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.direction,
      child: AlertDialog(
        title: ! widget.showSearchField ? Text(widget.title) : _buildSearchField(),

        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: displayedObjects.length,
              itemBuilder: (context, index) {
                T obj = displayedObjects[index];
                bool selected = selectedObjects.contains(obj);
                return CheckboxListTile(
                  key: ValueKey<String>("${widget.displayName(obj)}"),
                  value: selected,
                  onChanged: (_) => setState(() => _addOrRemoveObjectFromSelectedObjects(obj)),
                  title: Text(widget.displayName(obj)),
                );
              },
          ),
        ),

        actions: <Widget>[
          FlatButton(
            child: Text("done".tr),
            onPressed: () => Get.back<List<T>>(result: selectedObjects),
          ),

          FlatButton(
            child: Text("remove_all".tr),
            onPressed: () {
              selectedObjects.clear();
              setState(() {});
              print("${selectedObjects.length}");
              },
          )
        ],
      ),
    );
  }

  void _addOrRemoveObjectFromSelectedObjects(T object) {
    if(selectedObjects.contains(object)) selectedObjects.remove(object);
    else selectedObjects.add(object);
  }

  Widget _buildSearchField() {
    return _SearchField(
      inputDecoration: InputDecoration(
        hintText: widget.title
      ),
      onTextChanged: (text) => setState(() => displayedObjects =
          widget.allObjects.where((element) => widget.displayName(element).contains(text)).toList())
    );
  }
}

class _SearchField extends StatefulWidget {
  final InputDecoration inputDecoration;

  final Function(String) onTextChanged;

  const _SearchField({Key key, this.inputDecoration, this.onTextChanged}) : super(key: key);

  @override
  __SearchFieldState createState() => __SearchFieldState();
}

class __SearchFieldState extends State<_SearchField> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PositionedDirectional(end: 0.0, width: 35, height: 35,
              child: IconButton(icon: Icon(Icons.clear), onPressed: controller.clear,)
          ),

          PositionedDirectional(end: 35, start: 0.0,
            child: TextField(
              controller: controller,
              onChanged: widget.onTextChanged,
              decoration: widget.inputDecoration
            ),
          )
        ],
      ),
    );
  }
}

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

                RatingBar(
                  initialRating: newLowerBound,
                  onRatingUpdate: isActivated ? onLowerBoundChanged : null,
                  itemBuilder: (context, index) =>
                      Icon(
                          Icons.star,
                          color: isActivated ? Colors.amber : Colors.grey
                      ),
                ),

                Text('to'.tr, style: TextStyle(color: isActivated ? Colors.black : Colors.grey)),

                RatingBar(
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
