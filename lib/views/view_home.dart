
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/transaction.dart';
import 'components/chart/chart.dart';
import 'components/transaction/transaction_form.dart';
import 'components/transaction/transaction_list.dart';

class ViewHome extends StatefulWidget {
  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransactions);
        });
  }

  _openEditTransactionFormModal(BuildContext context, Transaction tr) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransactions, tr: tr);
        });
  }

  _addTransactions(Transaction tr) {
    setState(() {
      final index = _transactions.indexWhere((element) => tr.id == element.id);
      if (index >= 0) {
        _transactions[index] = tr;
      } else {
        _transactions.add(tr);
      }
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

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
            if (_showChart || !isLandscape)
              Container(
                child: Container(
                  height: availableHeight * (isLandscape ? 0.8 : 0.3),
                  child: Chart(_transactions, 6),
                  margin: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                ),
              ),
            if (!_showChart || !isLandscape)
              Column(
                children: [
                  Text("Últimas despesas", style: Theme.of(context).textTheme.titleLarge),
                  Container(
                      padding: EdgeInsets.only(top: 40),
                      height: availableHeight * (isLandscape ? 1 : 0.7),
                      child: TransactionList(_transactions, _deleteTransaction, (tr) {
                        _openEditTransactionFormModal(context, tr);
                      }))
                ],
              )
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