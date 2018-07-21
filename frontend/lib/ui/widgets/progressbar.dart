import 'dart:ui';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  double _globalWidth = 200.0;
  double percentage;
  Color positiveColor;
  Color negativeColor;

  ProgressBar({this.percentage, this.positiveColor, this.negativeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _globalWidth,
      height: 5.0,
      decoration: BoxDecoration(
        color: negativeColor,
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: positiveColor,
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            ),
            width: (percentage / 100) * _globalWidth,
          ),
        ],
      ),
    );
  }
}
