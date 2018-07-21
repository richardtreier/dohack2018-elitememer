import 'dart:ui';

import 'package:elitememer/ui/widgets/nav_scaffold.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildNavScaffold(
      context,
      Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage(
                    'https://i3.kym-cdn.com/photos/images/newsfeed/000/170/791/welcome-to-the-internet-internet-demotivational-poster-1264714433.png.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.black.withOpacity(0.5)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 30.0, bottom: 30.0, right: 15.0, left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Card(
                  child: Image.network(
                      'https://i3.kym-cdn.com/photos/images/newsfeed/000/170/791/welcome-to-the-internet-internet-demotivational-poster-1264714433.png.jpg'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.close),
                      onPressed: () => print('Trash'),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.favorite_border),
                      onPressed: () => print('Favorite'),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
