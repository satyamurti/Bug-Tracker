import 'package:flutter/material.dart';

class DatePickerButton extends StatefulWidget {
  const DatePickerButton({Key? key}) : super(key: key);

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  @override
  build(context) => ElevatedButton(
        onPressed: onPress,
        child: const Text('Select Date'),
      );

  Future<void> onPress() async {
    final curTime = DateTime.now();
    final newTime = await showDatePicker(
      context: context,
      initialDate: curTime,
      firstDate: curTime,
      lastDate: curTime.add(const Duration(days: 300)),
    );
    print(newTime);
  }
}
