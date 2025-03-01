import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import '../adaptative/adaptative_button.dart';
import '../adaptative/adaptative_month_picker.dart';
import '../adaptative/adaptative_text_field.dart';
import '../adaptative/months.dart';

class TransactionForm extends StatefulWidget {
  final void Function(Transaction) onSubmit;
  Transaction? tr;

  TransactionForm(this.onSubmit, {super.key, this.tr});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleControler = TextEditingController();
  final _valueController = TextEditingController();
  Month _selectedDate = Months.getActualMonth();

  _submitForm() {
    final title = _titleControler.text;
    final value = double.parse(_valueController.text);

    if (title.isEmpty || value <= 0) {
      return;
    }

    if (widget.tr != null) {
      final newTransaction = Transaction(id: widget.tr!.id, title: title, value: value, month: _selectedDate);
      widget.onSubmit(newTransaction);
    } else {
      final newTransaction = Transaction(id: Random().nextDouble().toString(), title: title, value: value, month: _selectedDate);
      widget.onSubmit(newTransaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.tr != null) {
      _titleControler.text = widget.tr!.title;
      _valueController.text = widget.tr!.value.toString();
      _selectedDate = widget.tr!.month;
    }
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
            bottom: 10 + MediaQuery
                .of(context)
                .viewInsets
                .bottom,
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
              child: AdaptativeMonthPicker(
                    (newDate) {
                  _selectedDate = newDate;
                },
                month: widget.tr?.month
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(
                  onPressed: () {
                    _submitForm();
                  },
                  label: widget.tr == null? "Nova transação": "Editar",
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
