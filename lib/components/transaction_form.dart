import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _selectedDate = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          TextField(
              controller: _titleControler,
              decoration: InputDecoration(labelText: "Título"),
              onSubmitted: (_) => _submitForm()),
          TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Valor R\$"),
              onSubmitted: (_) => _submitForm()),
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text('Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}')),
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
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: Text("Nova transação", style: Theme.of(context).textTheme.labelLarge),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
