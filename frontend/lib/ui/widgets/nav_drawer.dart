import 'package:flutter/material.dart';

Drawer buildNavDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: <Widget>[
        DrawerHeader(
          child: Image.network('https://i3.kym-cdn.com/photos/images/newsfeed/000/170/791/welcome-to-the-internet-internet-demotivational-poster-1264714433.png.jpg'
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