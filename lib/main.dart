import 'dart:io';

import 'package:expenses/views/Routes.dart';
import 'package:expenses/views/components/chart/chart.dart';
import 'package:expenses/views/components/transaction/transaction_form.dart';
import 'package:expenses/views/components/transaction/transaction_list.dart';
import 'package:expenses/views/view_home.dart';
import 'package:expenses/views/view_month_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatefulWidget {
  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {

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
    return MaterialApp(theme: appTheme(context),
     routes: {
      Routes.HOME: (_) => ViewHome(),
      Routes.MONTH_TRANSACTIONS: (_) => ViewMonthTransactions(),
     });
  }
}
