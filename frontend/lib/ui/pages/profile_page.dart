import 'dart:ui' as ui;
import 'package:elitememer/services/api_service/api_service.dart';
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
  void initState() {
    // PROFILE LOADING HERE
  }

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
        new Positioned(
          child: new FloatingActionButton(
            child: new Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
            ),
            onPressed: () {},
            backgroundColor: Colors.white,
          ),
          right: 10.0,
          top: MediaQuery.of(context).size.height / 1.8 - 5.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: const EdgeInsets.only(left: 110.0, right: 110.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          'https://p5.focus.de/img/fotos/origs9287567/8808514057-w630-h472-o-q75-p5/urn-newsml-dpa-com-20090101-180720-99-231079-large-4-3.jpg'),
                      radius: 45.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Angela',
                            style: TextStyle(fontSize: 28.0),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                child: Icon(
                                  Icons.trending_up,
                                  color: Colors.greenAccent,
                                  size: 28.0,
                                ),
                                padding: EdgeInsets.only(right: 8.0),
                              ),
                              Text('89%',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.greenAccent)),
                            ],
                          )
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
