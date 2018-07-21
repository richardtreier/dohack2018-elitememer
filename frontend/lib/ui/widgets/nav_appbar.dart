import 'package:flutter/material.dart';

AppBar buildNavAppBar(BuildContext context, {Widget title}) {
  return AppBar(
    title: title ?? Text('EliteMemer'),
  );
}