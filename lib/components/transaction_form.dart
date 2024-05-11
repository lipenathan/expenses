import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleControler = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleControler.text;
    final value = double.parse(valueController.text);

    if (title.isEmpty || value <= 0 ) {
      return;
    }
    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          TextField(
              controller: titleControler,
              decoration: InputDecoration(labelText: "Título"),
              onSubmitted: (_) => _submitForm()),
          TextField(
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Valor R\$"),
              onSubmitted: (_) => _submitForm()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text("Nova transação", style: TextStyle(color: Colors.purple))),
            ],
          )
        ]),
      ),
    );
  }
}
