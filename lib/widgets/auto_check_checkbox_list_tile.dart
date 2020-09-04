import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AutoCheckCheckboxListTile extends StatefulWidget {
  final Function(bool) onCheckChanged;

  final bool initialValue;
  final Color activeColor;
  final Color checkColor;
  final Widget title;
  final Widget subtitle;
  final bool isThreeLine;
  final bool dense;
  final secondary;
  final bool selected;
  final ListTileControlAffinity controlAffinity;

  AutoCheckCheckboxListTile({
    Key key, @required this.onCheckChanged,
    @required this.initialValue,
    this.activeColor,
    this.checkColor,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.secondary,
    this.selected = false,
    this.controlAffinity = ListTileControlAffinity.platform}) : super(key: key);

  @override
  _AutoCheckCheckboxListTileState createState() => _AutoCheckCheckboxListTileState(initialValue);
}

class _AutoCheckCheckboxListTileState extends State<AutoCheckCheckboxListTile> {
  bool _checked;

  _AutoCheckCheckboxListTileState(bool initialValue) : _checked = initialValue;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: widget.key,
      value: _checked,
      activeColor: widget.activeColor,
      checkColor: widget.checkColor,
      title: widget.title,
      subtitle: widget.subtitle,
      isThreeLine: widget.isThreeLine,
      dense: widget.dense,
      secondary: widget.secondary,
      selected: widget.selected,
      controlAffinity: widget.controlAffinity,
      onChanged: (checked) {
        setState(() => _checked = checked);
        widget.onCheckChanged(checked);
      },
    );
  }
}
