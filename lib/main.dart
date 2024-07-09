import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ThemeData appTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme.of(context).copyWith(backgroundColor: Theme.of(context).primaryColor),
      fontFamily: 'OpenSans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
        secondary: Colors.white,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
          labelLarge: TextStyle(fontFamily: 'OpenSans', color: Colors.white, fontWeight: FontWeight.bold)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(), theme: appTheme(context));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(id: 't0', title: 'Conta antiga', value: 310.76, date: DateTime.now().subtract(Duration(days: 33))),
    Transaction(
        id: 't1', title: 'Novo tenis de corrida', value: 240.11, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: 't2', title: 'Conta de luz', value: 240.11, date: DateTime.now().subtract(Duration(days: 4)))
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransactions);
        });
  }

  _addTransactions(String title, double value, DateTime date) {
    final newTransaction = Transaction(id: Random().nextDouble().toString(), title: title, value: value, date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Despesas pessoais'),
          actions: <Widget>[
            IconButton(
                onPressed: () => {_openTransactionFormModal(context)}, icon: Icon(Icons.add), color: Colors.white)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Container(
                    child: Chart(_recentTransactions), margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12)),
              ),
              TransactionList(_transactions, _deleteTransaction)
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () => {_openTransactionFormModal(context)}, child: Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
