import 'package:elitememer/ui/pages/chat_page.dart';
import 'package:elitememer/ui/pages/intro_page.dart';
import 'package:elitememer/ui/pages/matches_page.dart';
import 'package:elitememer/ui/pages/profile_page.dart';
import 'package:elitememer/ui/pages/swipe_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return new MaterialApp(
      title: 'EliteMemer',
      theme: new ThemeData.dark(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => IntroPage(),
        '/swipePage': (BuildContext context) => SwipePage(),
        '/chatPage': (BuildContext context) => ChatPage(),
        '/profilePage': (BuildContext context) => ProfilePage(),
        '/matchesPage': (BuildContext context) => MatchesPage(),
      },
    );
  }
}
