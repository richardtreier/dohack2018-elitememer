import 'dart:ui' as ui;

import 'package:elitememer/ui/widgets/nav_scaffold.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SwipePageState();
}

class SwipePageState extends State<SwipePage>
    with SingleTickerProviderStateMixin {
  DragStartDetails dragStart;
  double moved = 0.0;
  double movedPercentage = 0.0;
  AnimationController controller;

  List<String> memes = <String>[
    'https://i.imgur.com/UE5Meld.jpg',
    'https://i.imgur.com/5LZroHc.jpg',
    'https://i.imgur.com/277C2AY.jpeg',
  ];

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
  }

  @override
  Widget build(BuildContext context) {
    return buildNavScaffold(
      context,
      Stack(
        children: <Widget>[
          memes.length > 1
              ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(memes[1]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                )
              : Container(),
          Opacity(
            opacity: movedPercentage.abs(),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(memes[0]),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                ),
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
                  child: _buildMemeStack(context),
                  onHorizontalDragStart: (DragStartDetails start) =>
                      dragStart = start,
                  onHorizontalDragUpdate: (DragUpdateDetails update) {
                    setState(() {
                      moved += update.delta.dx;
                      movedPercentage =
                          moved / MediaQuery.of(context).size.width * 1.5;

                      final double discardPercentage = 0.6;

                      if (movedPercentage > discardPercentage ||
                          movedPercentage < -discardPercentage) {
                        memes.removeAt(0);
                        memes = memes;

                        moved = 0.0;
                        movedPercentage = 0.0;
                      }
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.close),
                      onPressed: () => animateSlide(false),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.favorite_border),
                      onPressed: () => animateSlide(true),
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

  Stack _buildMemeStack(BuildContext context) {
    int i = -1;

    return Stack(
      overflow: Overflow.visible,
      children: memes
          .map((String url) => SwipeCard(
              url: url,
              order: ++i,
              swipePercentage: i == 0 ? movedPercentage : 0.0))
          .toList()
          .reversed
          .toList(),
    );
  }

  void animateSlide(bool forward) {
    controller.reset();

    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.3)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    animation.addListener(() {
      setState(() {
        movedPercentage = forward ? animation.value : -animation.value;
      });
    });

    bool completed = false;
    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed && !completed) {
        completed = true;

        memes.removeAt(0);
        memes = memes;

        moved = 0.0;
        movedPercentage = 0.0;
      }
    });

    controller.forward();
  }
}

class SwipeCard extends StatelessWidget {
  final String url;
  final double swipePercentage;
  final int order;

  SwipeCard({this.url, this.swipePercentage = 0.0, @required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10.0 * order),
        child: SlideTransition(
            position: AlwaysStoppedAnimation<Offset>(
                Offset(swipePercentage * 1.2, (swipePercentage * 0.2).abs())),
            child: Transform.rotate(
              angle:
                  swipePercentage == 0.0 ? order / 30.0 : swipePercentage * 0.7,
              child: Card(
                child: Image.network(
                  url,
                  height: 300.0,
                  width: 300.0,
                ),
              ),
            )));
  }
}
