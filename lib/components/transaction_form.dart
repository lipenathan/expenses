import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_button.dart';
import 'adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleControler = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleControler.text;
    final value = double.parse(_valueController.text);

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showADatePicker() {
    showDatePicker(
            context: context as BuildContext,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _selectedDate = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: <Widget>[
            AdaptativeTextField(controller: _titleControler, label: "Título", onSubmitted: (_) => _submitForm()),
            AdaptativeTextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                label: "Valor R\$",
                onSubmitted: (_) => _submitForm()),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}')),
                  TextButton(
                    onPressed: _showADatePicker,
                    child: Text('Selecionar Data', style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(
                  onPressed: () {
                    _submitForm();
                  },
                  label: "Nova transação",
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
