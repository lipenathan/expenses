import 'package:expenses/views/components/transaction/transaction_item.dart';
import 'package:flutter/material.dart';
import '../../../models/transaction.dart';



class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final void Function(String) onDelete;
  final void Function(Transaction) _onItemClickListener;

  TransactionList(this._transactions, this.onDelete, this._onItemClickListener);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Text('Nenhuma Transação Cadastrada', style: Theme.of(context).textTheme.bodyMedium),
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
                return TransactionItem(tr, onDelete, _onItemClickListener, key: GlobalObjectKey(tr));
              }),
    );
  }
}
