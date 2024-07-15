import 'dart:io';
import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
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
    Transaction(id: 't0', title: 'Conta antiga', value: 310.76, date: DateTime.now()),
    Transaction(
        id: 't1', title: 'Novo tenis de corrida', value: 240.11, date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(id: 't2', title: 'Conta de água', value: 725.11, date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: 't3', title: 'Conta de telefone', value: 821.11, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: 't4', title: 'Cartão de crédito', value: 70.11, date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(id: 't5', title: 'Nova cozinha', value: 100.69, date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(id: 't6', title: 'Ferraentas', value: 20.11, date: DateTime.now().subtract(Duration(days: 6)))
  ];
  bool _showChart = false;

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
    final mediaQuery = MediaQuery.of(context);

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    var actions = <Widget>[
      if (isLandscape)
        IconButton(
          onPressed: () => {
            setState(() {
              _showChart = !_showChart;
            })
          },
          icon: _showChart
              ? Icon(
                  Icons.list,
                  color: Colors.white,
                )
              : Icon(Icons.show_chart, color: Colors.white),
        ),
      IconButton(
        onPressed: () => {_openTransactionFormModal(context)},
        icon: Icon(Icons.add),
        color: Colors.white,
      )
    ];
    final appBar = AppBar(
      title: Text(
        'Despesas pessoais',
        style: TextStyle(fontSize: mediaQuery.textScaler.scale(24.00)),
      ),
      actions: actions,
    );

    final double availableHeight = mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;

    var bodyPage = SafeArea(
      //área segura para iOS, para dispositivos que possuem note, por exemplo.
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Switch.adaptive( //adaptative mostra um botão para cada tipo de OS
            //       value: _showChart,
            //       onChanged: (value) {
            //         _showChart = value;
            //       }),
            if (_showChart || !isLandscape)
              Container(
                child: Container(
                  height: availableHeight * (isLandscape ? 0.8 : 0.3),
                  child: Chart(_recentTransactions),
                  margin: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                ),
              ),
            if (!_showChart || !isLandscape)
              Container(
                  height: availableHeight * (isLandscape ? 1 : 0.7),
                  child: TransactionList(
                    _transactions,
                    _deleteTransaction,
                  ))
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            //cria um scaffold(andaime/estrutura específica para o iOS)
            child: bodyPage,
            navigationBar: CupertinoNavigationBar(
              //um navigation bar que possui carácterísticas específas para o iOS.
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton:
                FloatingActionButton(onPressed: () => {_openTransactionFormModal(context)}, child: Icon(Icons.add)),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
