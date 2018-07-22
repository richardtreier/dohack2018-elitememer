import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Drawer buildNavDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: <Widget>[
        DrawerHeader(
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                'https://p5.focus.de/img/fotos/origs9287567/8808514057-w630-h472-o-q75-p5/urn-newsml-dpa-com-20090101-180720-99-231079-large-4-3.jpg'),
            radius: 68.0,
          ),
        ),
        ListTile(
          leading: Icon(Icons.swap_horiz),
          title: Text('Memes'),
          onTap: () => Navigator.pushNamed(context, '/swipePage'),
        ),
        ListTile(
          leading: Icon(Icons.done_all),
          title: Text('Matches'),
          onTap: () => Navigator.pushNamed(context, '/matchesPage'),
        )
      ],
    ),
  );
}
