import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _transactions = [];
  final void Function(String) onDelete;

  TransactionList(this._transactions, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Text('Nenhuma Transação Cadastrada', style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 20),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset("assets/images/waiting.png", fit: BoxFit.cover))
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final tr = _transactions[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: FittedBox(
                            child: Text(
                              'R\$${tr.value}',
                            ),
                          ),
                        )),
                    title: Text(tr.title, style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                    trailing: MediaQuery.of(context).size.width > 480
                        ? TextButton.icon(
                            onPressed: () {
                              onDelete(_transactions[index].id);
                            },
                            label: Text(
                              "Excluir",
                              style: TextStyle(color: Theme.of(context).colorScheme.error),
                            ),
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            ))
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).colorScheme.error,
                            onPressed: () {
                              onDelete(_transactions[index].id);
                            },
                          ),
                  ),
                );
              }),
    );
  }
}
