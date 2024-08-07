import 'package:expenses/components/transaction_item.dart';
import 'package:flutter/material.dart';

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
              return TransactionItem(tr, onDelete, key: GlobalObjectKey(tr));
            }),
            // : ListView(
            //     children: _transactions.map((tr) {
            //     return TransactionItem(
            //       tr,
            //       onDelete,
            //       key: ValueKey(tr.id),
            //     );
            //   }).toList())
        );
  }
}
