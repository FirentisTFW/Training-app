import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final Function _updateClient;

  const DatePicker(this._updateClient);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _birthDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: _birthDate == null
                ? Text('Choose Birth Date')
                : Text('Birth Date: ${DateFormat.yMd().format(_birthDate)}'),
          ),
          RaisedButton(
            child: Text('Choose Date'),
            onPressed: _pickDate,
          ),
        ],
      ),
    );
  }

  Future _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1980),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) {
      return;
    }
    setState(() {
      _birthDate = pickedDate;
      widget._updateClient('birthDate', _birthDate);
    });
  }
}
