import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sham_mobile/helpers/get_extensions.dart';

class DefaultFilterDialog<T> extends StatefulWidget {
  final List<T> allObjects;

  final List<T> initiallySelectedObjects;

  final String title;

  final String Function(T) displayName;

  final bool showSearchField;

  const DefaultFilterDialog({Key key,
    @required this.allObjects,
    @required this.initiallySelectedObjects,
    @required this.title,
    @required this.displayName,
    this.showSearchField = false, }) : super(key: key);

  @override
  _DefaultFilterDialogState<T> createState() => _DefaultFilterDialogState<T>();
}

class _DefaultFilterDialogState<T> extends State<DefaultFilterDialog<T>> {
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