import 'dart:ui';

import 'package:elitememer/ui/widgets/nav_scaffold.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwipePageState();
}

class SwipePageState extends State<SwipePage> {
  DragStartDetails dragStart;
  double moved = 0.0;

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
                GestureDetector(
                  child:                 Stack(
                    overflow: Overflow.visible,
                    fit: StackFit.loose,
                    children: <Widget>[
                      SwipeCard(swipePercentage: moved / MediaQuery.of(context).size.width * 1.5,)
                    ],
                  ),
                  onHorizontalDragStart: (DragStartDetails start) => dragStart = start,
                  onHorizontalDragUpdate: (DragUpdateDetails update) {
                    setState(() {
                      moved += update.delta.dx;
                    });
                  },
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

class SwipeCard extends StatelessWidget {
  double swipePercentage;
  int order;

  SwipeCard({this.swipePercentage = 0.0, @required this.order});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: AlwaysStoppedAnimation<Offset>(Offset(swipePercentage * 1.2, (swipePercentage * 0.2).abs())),
      child: Transform.rotate(
        angle: swipePercentage * 0.7,
        child: Card(
          child: Image.network(
              'https://i3.kym-cdn.com/photos/images/newsfeed/000/170/791/welcome-to-the-internet-internet-demotivational-poster-1264714433.png.jpg'),
        ),
      ),
    );
  }
}
