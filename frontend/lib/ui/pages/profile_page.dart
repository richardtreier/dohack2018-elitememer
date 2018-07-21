import 'dart:ui';
import 'package:elitememer/ui/widgets/nav_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatelessWidget {
  int _matchValue = 10;
  int _enemyValue = 40;

  List<String> _memes = [
    'https://i.imgur.com/UE5Meld.jpg',
    'https://i.imgur.com/5LZroHc.jpg',
    'https://i.imgur.com/277C2AY.jpeg',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  Widget _buildProfileHeaderImage(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 260.0,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: NetworkImage(
              'https://3c1703fe8d.site.internapcdn.net/newman/csz/news/800/2017/neutrinofaci.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: new Container(
          decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return new CircleAvatar(
      backgroundImage: new NetworkImage(
          'https://p5.focus.de/img/fotos/origs9287567/8808514057-w630-h472-o-q75-p5/urn-newsml-dpa-com-20090101-180720-99-231079-large-4-3.jpg'),
      radius: 60.0,
    );
  }

  Widget _buildInfo() {
    return Column(
      children: <Widget>[
        new Text(
          'Name',
          textScaleFactor: 1.5,
        ),
        new Slider(
          activeColor: Colors.green,
          min: 0.0,
          max: 100.0,
          value: _matchValue.toDouble(),
          onChanged: (double newValue) {
            _matchValue = newValue.round();
          },
        ),
        new Slider(
          activeColor: Colors.red,
          min: 0.0,
          max: 100.0,
          value: _enemyValue.toDouble(),
          onChanged: (double newValue) {
            _enemyValue = newValue.round();
          },
        )
      ],
    );
  }

  void _select() {}

  Widget _buildChat() {
    return FloatingActionButton(
      elevation: 0.0,
      child: new Icon(Icons.message),
      backgroundColor: new Color(0xFFE57373),
      onPressed: (){}
    );
  }

  Widget _buildMemeCarousel(BuildContext context) {
    return CarouselSlider(
        items: _memes.map((url) {
          return new Container(
              margin: new EdgeInsets.all(5.0),
              child: new ClipRRect(
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  child: new CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.contain,
                  )));
        }).toList(),
        height: 350.0,
        autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return buildNavScaffold(
      context,
      Stack(
        children: [
          _buildProfileHeaderImage(context),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 80.0, bottom: 30.0, right: 0.0, left: 80.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildAvatar(),
                    _buildInfo(),
                  ],
                ),
              ),
              _buildChat(),
              Padding(
                padding: EdgeInsets.only(
                    top: 20.0, bottom: 30.0, right: 0.0, left: 0.0),
                child: _buildMemeCarousel(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
