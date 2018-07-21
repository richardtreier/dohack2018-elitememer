import 'dart:ui' as ui;
import 'package:elitememer/ui/widgets/nav_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                      image: CachedNetworkImageProvider(memes[1]),
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
            opacity: 1 - movedPercentage.abs(),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(memes[0]),
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
                          moved / MediaQuery.of(context).size.width;

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
                  onHorizontalDragEnd: (DragEndDetails end) {
                    setState(() {
                      movedPercentage =
                          moved / MediaQuery.of(context).size.width;

                      final double discardPercentage = 0.3;

                      if (movedPercentage > discardPercentage) {
                        animateSlide(true, true, movedPercentage);
                      } else if (movedPercentage < -discardPercentage) {
                        animateSlide(false, true, -movedPercentage);
                      } else if (movedPercentage < discardPercentage) {
                        animateSlide(true, false, movedPercentage);
                      } else if (movedPercentage > -discardPercentage) {
                        animateSlide(false, false, movedPercentage);
                      }
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.close),
                      onPressed: () => animateSlide(false, true, 0.0),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.star),
                      onPressed: () => animateSlide(true, true, 0.0),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.favorite_border),
                      onPressed: () => animateSlide(true, true, 0.0),
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
    if (memes.isEmpty) {
      return Stack(
        children: <Widget>[],
      );
    }

    int i = -1;

    return Stack(
      overflow: Overflow.visible,
      children: memes
          .map((String url) => SwipeCard(
              url: url,
              order: ++i,
              swipePercentage: i == 0 ? movedPercentage * 1.3 : 0.0))
          .toList()
          .reversed
          .toList(),
    );
  }

  void animateSlide(bool forward, bool accepted, double position) {
    controller.reset();

    Animation<double> animation;

    accepted == true
        ? animation = Tween<double>(begin: position, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut))
        : animation = Tween<double>(begin: position, end: 0.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    animation.addListener(() {
      setState(() {
        movedPercentage = forward ? animation.value : -animation.value;
      });
    });

    bool completed = false;
    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed && !completed) {
        completed = true;

        if (accepted) {
          memes.removeAt(0);
          memes = memes;
        }

        moved = 0.0;
        movedPercentage = 0.0;
        position = 0.0;
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
                child: CachedNetworkImage(
                  imageUrl: url,
                  height: 300.0,
                  width: 300.0,
                ),
              ),
            )));
  }
}
