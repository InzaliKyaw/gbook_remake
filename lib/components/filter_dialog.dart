import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final String labelOne;
  final String labelTwo;
  final String labelThree;
  final String title;
  final Function(String) onChooseFilter;

  const FilterDialog({super.key, required this.labelOne,required this.labelTwo,required this.labelThree, required this.title,required this.onChooseFilter});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String selectedView = 'List view';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          _buildSelectableTile(widget.labelOne, selectedView),
          _buildSelectableTile(widget.labelTwo, selectedView),
          _buildSelectableTile(widget.labelThree, selectedView),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildSelectableTile(String title, String selected) {
    return ListTile(
        title: Text(title),
        tileColor: selected == title ? Colors.blue.shade100 : null,
        onTap: () {
          widget.onChooseFilter(title);
          /*
          _setSelectedView(title);
          if(title == "Small grid view"){
            setState(() {
            });
          }
          Navigator.pop(context);
           */
        }
    );
  }
}