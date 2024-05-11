import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, primary: Colors.yellow),
          appBarTheme: AppBarTheme.of(context).copyWith(backgroundColor: Theme.of(context).primaryColor)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(id: 't1', title: 'Novo Tênis de corrida', value: 310.76, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Conta de luz', value: 240.11, date: DateTime.now())
  ];

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransactions);
        });
  }

  _addTransactions(String title, double value) {
    final newTransaction =
        Transaction(id: Random().nextDouble().toString(), title: title, value: value, date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
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
                  child: Card(
                      color: Colors.blue,
                      child:
                          Container(child: Text('Grafico'), margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12)),
                      elevation: 5)),
              TransactionList(transactions: _transactions)
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () => {_openTransactionFormModal(context)}, child: Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
