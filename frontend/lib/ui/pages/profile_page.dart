import 'package:elitememer/ui/widgets/nav_scaffold.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';

class ProfilePage extends StatelessWidget {
  int _matchValue = 10;
  int _enemyValue = 40;

  Widget _buildProfileHeaderImage(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 280.0,
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

  Widget _buildChat() {}

  Widget _buildMemeCarousel(BuildContext context) {
    return CarouselSlider(
        items: [1, 2, 3, 4, 5].map((i) {
          return new Builder(
            builder: (BuildContext context) {
              return new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: new BoxDecoration(color: Colors.amber),
                  child: new Text(
                    'text $i',
                    style: new TextStyle(fontSize: 16.0),
                  ));
            },
          );
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
                    top: 80.0, bottom: 30.0, right: 15.0, left: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildAvatar(),
                    _buildInfo(),
                    // _buildChat(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 90.0, bottom: 30.0, right: 15.0, left: 15.0),
                child: _buildMemeCarousel(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
