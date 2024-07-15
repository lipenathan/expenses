import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  AdaptativeButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label, style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.symmetric(horizontal: 20),
            onPressed: onPressed,
            color: Theme.of(context).primaryColor)
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(label, style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
          );
  }
}
