import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:elitememer/ui/pages/swipe_page.dart';

class IntroPage extends StatelessWidget {
  final pages = [
    new PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        //iconImageAssetPath: 'assets/air-hostess.png',
        iconColor: null,
        bubbleBackgroundColor: null,
        body: Text(
          'Meet new people with humor by matching memes',
        ),
        title: Text(
          'Memes',
        ),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Image.asset(
          'graphics/intro_1.jpg',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    new PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      //iconImageAssetPath: 'assets/waiter.png',
      iconColor: null,
      bubbleBackgroundColor: null,
      body: Text(
        'View your matches and see if they are a Meme-Snob or -Bob',
      ),
      title: Text('Matches'),
      mainImage: Image.asset(
        'graphics/intro_2.jpg',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    new PageViewModel(
      pageColor: const Color(0xFF607D8B),
      //iconImageAssetPath: 'assets/taxi-driver.png',
      iconColor: null,
      bubbleBackgroundColor: null,
      body: Text(
        'See the favorites of your matches and contact them',
      ),
      title: Text('Social'),
      mainImage: Image.asset(
        'graphics/intro_3.jpg',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new IntroViewsFlutter(
      pages,
      onTapDoneButton: () {
        Navigator.push<dynamic>(
          context,
          new MaterialPageRoute<dynamic>(
              builder: (context) => new SwipePage()), //MaterialPageRoute
        );
      },
      showSkipButton: true, //Whether you want to show the skip button or not.
      pageButtonTextStyles: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );
  }
}
