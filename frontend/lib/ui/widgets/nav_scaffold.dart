import 'package:elitememer/ui/widgets/nav_appbar.dart';
import 'package:elitememer/ui/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

Scaffold buildNavScaffold(BuildContext buildContext, Widget body,
    {Widget title, Widget floatingAction}) {
  return Scaffold(
    drawer: buildNavDrawer(buildContext),
    appBar: buildNavAppBar(buildContext),
    body: body,
    floatingActionButton: floatingAction,
  );
}
