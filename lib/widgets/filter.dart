import 'package:flutter/material.dart';

class FilterOptionsWidget extends StatefulWidget {
  final Function(String) onFilterSelected;

  FilterOptionsWidget({Key? key, required this.onFilterSelected}) : super(key: key);

  @override
  _FilterOptionsWidgetState createState() => _FilterOptionsWidgetState();
}

class _FilterOptionsWidgetState extends State<FilterOptionsWidget> {
  DateTimeRange? selectedDateRange;
  String currentFilter = 'Filter';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: GestureDetector(
            onTap: () => _showFilterOptions(context),
            child: Text(currentFilter, style: TextStyle(color: Colors.green)),
          ),
        ),
        ListTile(
          title: Text('All'),
          onTap: () => _applyFilter('all'),
        ),
        ListTile(
          title: Text('Today'),
          onTap: () => _applyFilter('today'),
        ),
        ListTile(
          title: Text('Last 7 Days'),
          onTap: () => _applyFilter('last_7_days'),
        ),
        ListTile(
          title: Text('Last 30 Days'),
          onTap: () => _applyFilter('last_30_days'),
        ),
        ListTile(
          title: Text('Last 1 Year'),
          onTap: () => _applyFilter('last_1_year'),
        ),
        ListTile(
          title: Text('Custom'),
          onTap: () => _selectCustomDateRange(context),
        ),
      ],
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Your list tiles for filters go here
          ],
        );
      },
    );
  }

  void _applyFilter(String filter) {
    print("Selected filter: $filter"); // Print to console
    widget.onFilterSelected(filter); // Call the callback with the selected filter
    setState(() {
      currentFilter = filter;
    });
    Navigator.of(context).pop();
  }

  Future<void> _selectCustomDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: selectedDateRange,
      saveText: 'Apply',
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
        currentFilter = '${picked.start.toString().split(' ')[0]} - ${picked.end.toString().split(' ')[0]}';
        // TODO: Apply the custom date range filter
      });
    }
  }
}
