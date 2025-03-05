import 'package:expenses/models/transaction.dart';
import 'package:expenses/views/Routes.dart';
import 'package:flutter/material.dart';

import '../adaptative/months.dart';
import 'chart_bar.dart';

class Chart extends StatefulWidget {
  final List<Transaction> transactions;
  final int chartLength;

  Chart(this.transactions, this.chartLength);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  //agrupa as transações por mês
  Map<String, List<Transaction>> get getGroupedTransactions {
    var groupedTransactions = Map<String, List<Transaction>>();
    widget.transactions.forEach((tr) {
      groupedTransactions[tr.month.monthShort] = List<Transaction>.empty(growable: true);
    });
    widget.transactions.forEach((tr) {
      groupedTransactions[tr.month.monthShort]?.add(tr);
    });
    return groupedTransactions;
  }

  //soma o valor total no período
  double get _periodTotalValue {
    var sum = 0.0;
    if (getGroupedTransactions.isEmpty) {
      return 0.0;
    } else {
      getGroupedTransactions.forEach((key, value) {
        sum += value.fold(0.0, (previousValue, element) => previousValue + element.value);
      });
      return sum;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastMonths = Months.getLast(widget.chartLength);

    var chartItens = List<Flexible>.generate(widget.chartLength, (index) {
      final possibleMonth = getGroupedTransactions[lastMonths[index].monthShort];
      final total = possibleMonth == null
          ? 0.0
          : possibleMonth.fold(0.0, (previousValue, element) => previousValue + element.value);

      final percentage = _periodTotalValue == 0.0 ? 0.0 : total / _periodTotalValue;
      return Flexible(
          fit: FlexFit.tight,
          child: ChartBar(
              label: lastMonths[index].monthShort,
              percentage: percentage,
              value: total,
              onItemClick: () {
                final transactions = widget.transactions.where((tr) => tr.month == lastMonths[index]).toList();
                Navigator.of(context).pushNamed(Routes.MONTH_TRANSACTIONS, arguments: transactions);
              }));
    });

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: chartItens.reversed.toList(),
        ),
      ),
    );
  }
}
