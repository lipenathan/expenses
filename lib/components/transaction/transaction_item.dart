import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final Function(String) onDelete;

  final Function(Transaction) _onItemClickListener;

  const TransactionItem(this.tr, this.onDelete, this._onItemClickListener, {super.key});

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color _backgroundColor = Colors.white;

  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {widget._onItemClickListener(widget.tr)},
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: _backgroundColor,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  child: Text(
                    'R\$${widget.tr.value}',
                  ),
                ),
              )),
          title: Text(widget.tr.title, style: Theme.of(context).textTheme.titleMedium),
          subtitle: Text(widget.tr.month.monthShort),
          trailing: MediaQuery.of(context).size.width > 480
              ? TextButton.icon(
                  onPressed: () {
                    widget.onDelete(widget.tr.id);
                  },
                  label: Text(
                    "Excluir",
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ))
              : IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () {
                    widget.onDelete(widget.tr.id);
                  },
                ),
        ),
      ),
    );
  }
}
