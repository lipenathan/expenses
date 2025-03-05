import 'package:flutter/material.dart';

import 'months.dart';

class AdaptativeMonthPicker extends StatefulWidget {
  final Function(Month) onMonthChanged;
  final Month? month;

  AdaptativeMonthPicker(this.onMonthChanged, {this.month});

  @override
  State<AdaptativeMonthPicker> createState() => _AdaptativeMonthPickerState();
}

class _AdaptativeMonthPickerState extends State<AdaptativeMonthPicker> {
  Month? _month;
  Month? _actualMonth;

  @override
  void initState() {
    if (widget.month == null) {
      _actualMonth = Months.getActualMonth();
    } else {
      _month = widget.month;
    }
    super.initState();
  }

  void _onMonthSelected(Month newMonth) {
    this.widget.onMonthChanged(newMonth);
    setState(() {
      _month = newMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(children: <Widget>[
        Text(_month == null ? 'Nenhum mês selecionado' : ""),
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListView(
                      shrinkWrap: true,
                      children: Months.values().map((month) {
                        return ListTile(
                          title: Text(_actualMonth == month ? "${month.month}(mês atual)" : month.month),
                          onTap: () {
                            _onMonthSelected(month);
                            Navigator.of(context).pop(month);
                          },
                        );
                      }).toList(),
                    ),
                  );
                });
          },
          child: Text(
            '${_month == null ? 'Selecione um mês' : '${_month!.month}(clique para alterar)'}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
        // TextButton(
        //   onPressed: () {},
        //   child: const Text(
        //     'Selecione mês',
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // )
      ]),
    );
  }
}
