import 'dart:ui' as ui;
import 'package:elitememer/main.dart';
import 'package:elitememer/services/api_service/api_service.dart';
import 'package:elitememer/ui/pages/matches_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  List<String> _memes = [
    'https://i.imgur.com/UE5Meld.jpg',
    'https://i.imgur.com/5LZroHc.jpg',
    'https://i.imgur.com/277C2AY.jpeg',
  ];

  @override
  void initState() {}

  Widget _buildMemeCarousel(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: CarouselSlider(
                items: _memes.map((url) {
                  return new Container(
                      child: new ClipRRect(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          child: new CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                          )));
                }).toList(),
                height: 350.0,
                autoPlay: true),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: new Icon(
          Icons.chat_bubble_outline,
          color: Colors.black,
        ),
        onPressed: () {},
        backgroundColor: Colors.white,
      ),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 3.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://3c1703fe8d.site.internapcdn.net/newman/csz/news/800/2017/neutrinofaci.jpg',
                  ),
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
            SafeArea(
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context))),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              navigationTarget.image.imgurURL),
                          radius: 45.0,
                        ),
                      ],
                      alignment: Alignment.centerRight,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                  (83 -
                                                  ((navigationTarget.uuid
                                                                      .length %
                                                                  2 +
                                                              1) *
                                                          7) *
                                                      currentI) %
                                              5 ==
                                          0
                                      ? 'graphics/meme_snob.png'
                                      : 'graphics/meme_bob.png',
                                  height: 40.0,
                                  width: 40.0),
                              Text(
                                navigationTarget.name,
                                style: TextStyle(fontSize: 28.0),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                child: Icon(
                                  Icons.trending_up,
                                  color: Colors.greenAccent,
                                  size: 28.0,
                                ),
                                padding: EdgeInsets.only(right: 8.0),
                              ),
                              Text(
                                  '${navigationTarget.matchPercentage.toInt()}%',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.greenAccent)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: _buildMemeCarousel(context),
    );
  }
}
