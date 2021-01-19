import 'package:flutter/material.dart';

class NumberSpinner extends StatefulWidget {
  final double minValue;

  final double maxValue;

  final double incrementValue;

  final double initialValue;

  /// Multiplies the increment value with this number on
  /// long press
  final double longPressMultiplier;

  final Color buttonColor;

  final double buttonSize;

  final Function(double) onValueChanged;

  final bool showDecimalPoint;

  const NumberSpinner({Key key,
    this.minValue = 0,
    this.maxValue = double.maxFinite,
    this.incrementValue = 1,
    this.initialValue = 0,
    this.longPressMultiplier = 2,
    this.buttonColor = Colors.black,
    this.buttonSize = 25,
    this.onValueChanged,
    this.showDecimalPoint = false
  }) : super(key: key);

  @override
  _NumberSpinnerState createState() => _NumberSpinnerState();
}

class _NumberSpinnerState extends State<NumberSpinner> {
  TextEditingController textEditingController;

  final FocusNode fieldFocusNode = FocusNode();

  @override
  void initState() {
    textEditingController = TextEditingController();
    setValue(widget.initialValue);

    // Sets the field's value to minValue if it is empty
    // when focus is lost
    fieldFocusNode.addListener(() {
      if(! fieldFocusNode.hasFocus) {
        if(textEditingController.text.isEmpty)
          setValue(widget.minValue);
      }
    });
    super.initState();
  }

  void setValue(double value) {
    textEditingController.text = widget.showDecimalPoint ? value.toString() : value.toInt().toString();
    widget.onValueChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            focusNode: fieldFocusNode,
            controller: textEditingController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
        ),

        SizedBox(width: 30),

        GestureDetector(
          onTap: decrement,
          onLongPressStart: (_) => onLongDecrement(),
          onLongPressEnd: (_) => decrementLongPressed = false,

          child: Icon(
            Icons.remove_circle_outline,
            size: widget.buttonSize,
            color: widget.buttonColor,
          ),
        ),

        SizedBox(width: 15),

        GestureDetector(
          onTap: increment,
          onLongPressStart: (_) => onLongIncrement(),
          onLongPressEnd: (_) => incrementLongPressed = false,
          child: Icon(
              Icons.add_circle_outline,
              size: widget.buttonSize,
              color: widget.buttonColor
          ),
        ),
      ],
    );
  }

  void increment({bool useMultiplier = false}) {
    double currentValue = double.parse(textEditingController.text);
    currentValue += widget.incrementValue * (useMultiplier ? widget.longPressMultiplier : 1);
    if(currentValue > widget.maxValue) currentValue = widget.maxValue;
    setValue(currentValue);
  }

  void decrement({bool useMultiplier = false}) {
    double currentValue = double.parse(textEditingController.text);
    currentValue -= widget.incrementValue * (useMultiplier ? widget.longPressMultiplier : 1);
    if(currentValue < widget.minValue) currentValue = widget.minValue;
    setValue(currentValue);
  }

  bool incrementLongPressed = false;

  void onLongIncrement() async {
    incrementLongPressed = true;

    while(incrementLongPressed) {
      increment(useMultiplier: true);
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  bool decrementLongPressed = false;

  void onLongDecrement() async {
    decrementLongPressed = true;

    while(decrementLongPressed) {
      decrement(useMultiplier: true);
      await Future.delayed(Duration(milliseconds: 200));
    }
  }
}
