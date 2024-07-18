import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {

  final DateTime? _selectedDate = null;
  final Function(DateTime) onDateChanged;

  AdaptativeDatePicker({required this.onDateChanged});

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? SizedBox(
        height: 100,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          minimumDate: DateTime(2019),
          maximumDate: DateTime.now(),
          onDateTimeChanged: onDateChanged,
        )) :
    SizedBox(
      height: 70,
      child: Row(
          children: <Widget>[
            Text(
                _selectedDate == null ? 'Nenhuma data selecionada' : 'Data selecionada: ${DateFormat('dd/MM/yy').format(
                    _selectedDate)}'
            ),
            TextButton(onPressed: _showDatePicker(context), child: const Text('Selecionar Data', style: TextStyle(
                fontWeight: FontWeight.bold
            ),))
          ]
      ),
    );
  }
}