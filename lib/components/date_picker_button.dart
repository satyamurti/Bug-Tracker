import 'package:bug_tracker/util/date_format.dart';
import 'package:flutter/material.dart';

class DatePickerButton extends StatefulWidget {
  final String text;
  final void Function(DateTime date) onDateSelected;

  const DatePickerButton({
    Key? key,
    required this.text,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  bool firstSelect = true;
  DateTime date = DateTime.now();

  @override
  build(context) => ElevatedButton(
        onPressed: showDialog,
        child: Text(
          firstSelect ? widget.text : 'Deadline: ${dateFormat.format(date)}',
        ),
      );

  Future<void> showDialog() async {
    final curTime = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: curTime,
      lastDate: curTime.add(const Duration(days: 100)),
    );
    if (newDate != null) {
      setState(() {
        firstSelect = false;
        date = newDate;
      });
      widget.onDateSelected(newDate);
    }
  }
}
