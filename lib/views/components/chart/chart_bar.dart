import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  final Function() onItemClick;

  ChartBar({required this.label, required this.percentage, required this.value, required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: onItemClick,
        child: Column(children: <Widget>[
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text(
                'R\$${value.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.labelSmall,
              ))),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ])),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label),
            ),
          )
        ]),
      );
    });
  }
}
