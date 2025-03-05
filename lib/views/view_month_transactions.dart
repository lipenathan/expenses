import 'package:expenses/models/transaction.dart';
import 'package:expenses/views/components/transaction/transaction_item.dart';
import 'package:flutter/material.dart';

class ViewMonthTransactions extends StatelessWidget {
  Widget build(BuildContext context) {
    List<Transaction> transactions = ModalRoute.of(context)!.settings.arguments as List<Transaction>;

    return Scaffold(
      appBar: AppBar(
          title:
              Text(transactions.isNotEmpty ? transactions[0].month.month : "Nenhuma transação para o mês selecionado")),
      body: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            return TransactionItem(transactions[index], (_) {}, (_) {});
          })
    );
  }
}
