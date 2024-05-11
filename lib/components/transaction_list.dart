import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _transactions = [];

  TransactionList({super.key, required List<Transaction> transactions}) {
    _transactions = transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text('Nenhuma Transação Cadastrada', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 20),
                Container(height: 200, child: Image.asset("assets/images/waiting.png", fit: BoxFit.cover))
              ],
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final tr = _transactions[index];
                return Card(
                    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2)),
                            padding: const EdgeInsets.all(10),
                            child: Text('R\$ ${tr.value}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.primary))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(tr.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(DateFormat('d MMM y').format(tr.date), style: const TextStyle(color: Colors.grey))
                          ],
                        )
                      ],
                    ));
              }),
    );
  }
}
