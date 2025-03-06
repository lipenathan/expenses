import 'package:expenses/models/transaction.dart';
import 'package:expenses/views/components/transaction/transaction_item.dart';
import 'package:flutter/material.dart';

class ViewMonthTransactions extends StatelessWidget {
  Widget build(BuildContext context) {
    Map<String, List<Transaction>> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, List<Transaction>>;

    final month = arguments.keys.first;
    final verifiedList = arguments[month] ?? List<Transaction>.empty();
    final emptyList = arguments[month]!.isEmpty;

    List<Transaction> transactions = emptyList ? List<Transaction>.empty() : verifiedList;

    return Scaffold(
      appBar: AppBar(title: Text(month)),
      body: !emptyList
          ? ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(transactions[index], (_) {}, (_) {});
              })
          : Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Nenhuma Transação para este mês",
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
    );
  }
}