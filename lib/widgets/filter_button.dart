import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sham_mobile/models/filter.dart';
import 'package:get/get_utils/get_utils.dart';

class FilterButton<T extends Filtered> extends StatefulWidget {
  final List<Filter> filters;

  const FilterButton({Key key, @required this.filters}) : super(key: key);

  @override
  _FilterButtonState createState() => _FilterButtonState<T>();
}

class _FilterButtonState<T extends Filtered> extends State<FilterButton> {
  Filter _selectedFilter = Filter.none;

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, value, _) =>
          PopupMenuButton<Filter>(
              icon: Icon(Icons.filter_list),
              itemBuilder: (context) =>
                  _getItems(context)
          ),
    );
  }

  List<CheckedPopupMenuItem<Filter>> _getItems(BuildContext context) {
    return widget.filters.map((filter) =>
        CheckedPopupMenuItem<Filter>(
          checked: _selectedFilter == filter,
          value: filter,
          child: Text(filter.toString().tr),
        )
    ).toList();
  }
}