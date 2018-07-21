import 'package:elitememer/ui/pages/swipe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return new MaterialApp(
      title: 'EliteMemer',
      theme: new ThemeData.dark(),
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => SwipePage(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/swipePage': (context) => SwipePage(),
      },
    );
  }
}