import 'package:elitememer/ui/widgets/nav_scaffold.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildNavScaffold(
        context,
        ListView(
          children: <Widget>[
            _UserTile(
              status: _MemeStatus.MemeBob,
              imagePath: 'graphics/man_portrait.jpg',
              profileName: 'Niklas',
              percentage: '94%',
            ),
            Divider(
              height: 0.0,
            ),
            _UserTile(
              status: _MemeStatus.MemeSnob,
              imagePath: 'graphics/placeholder.png',
              profileName: 'Peter',
              percentage: '89%',
            ),
            Divider(
              height: 0.0,
            ),
            _UserTile(
              status: _MemeStatus.MemeBob,
              imagePath: 'graphics/placeholder.png',
              profileName: 'MEEEEEEEEME!!1',
              percentage: '82%',
            ),
            Divider(
              height: 0.0,
            ),
            _UserTile(
              status: _MemeStatus.MemeSnob,
              imagePath: 'graphics/placeholder.png',
              profileName: 'Pascal',
              percentage: '79%',
            ),
          ],
        ));
  }
}

enum _MemeStatus { MemeSnob, MemeBob, Normie }

class _UserTile extends StatelessWidget {
  final _MemeStatus status;
  final String profileName;
  final String imagePath;
  final String percentage;

  _UserTile(
      {this.status = _MemeStatus.Normie,
      this.profileName,
      this.imagePath,
      this.percentage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/profilePage'),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage(imagePath),
          ),
          title: Text(
            profileName,
            style: TextStyle(fontSize: 26.0),
          ),
          trailing: status != _MemeStatus.Normie
              ? Image.asset(
                  status == _MemeStatus.MemeSnob
                      ? 'graphics/meme_snob.png'
                      : 'graphics/meme_bob.png',
                  height: 55.0,
                  width: 55.0,
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.trending_up,
                color: Colors.greenAccent,
                size: 28.0,
              ),
              Text(' ' + percentage,
                  style: TextStyle(fontSize: 24.0, color: Colors.greenAccent)),
            ],
          ),
        ),
      ),
    );
  }
}
