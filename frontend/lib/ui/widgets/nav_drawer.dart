import 'package:flutter/material.dart';

Drawer buildNavDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: <Widget>[
        DrawerHeader(
          child: Image.asset('graphics/welcome-to-the-internet.jpg'
          , fit: BoxFit.cover,),
        ),
        ListTile(
          leading: Icon(Icons.thumb_up),
          title: Text('Memes'),
          onTap: () => Navigator.pushNamed(context, '/swipePage'),
        ),
        ListTile(
          leading: Icon(Icons.chat),
          title: Text('Matches'),
          onTap: () => Navigator.pushNamed(context, '/matchesPage'),
        )
      ],
    ),
  );
}