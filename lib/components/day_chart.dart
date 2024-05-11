import 'package:flutter/material.dart';

class DayChart extends StatelessWidget {
  int porcentagem = 0;

  DayChart(int porcentagem) {
    if (porcentagem < 0) {
      this.porcentagem = 0;
    } else {
      this.porcentagem = porcentagem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
        child: FractionallySizedBox(
      heightFactor: porcentagem / 100,
      child: Container(
        color: Colors.red,
      ),
    ));
  }
}
