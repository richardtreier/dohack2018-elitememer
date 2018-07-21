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
            ),
            Divider(
              height: 0.0,
            ),
            _UserTile(),
            Divider(
              height: 0.0,
            ),
            _UserTile(),
            Divider(
              height: 0.0,
            ),
            _UserTile(status: _MemeStatus.MemeSnob),
          ],
        ));
  }
}

enum _MemeStatus { MemeSnob, MemeBob, Normie }

class _UserTile extends StatelessWidget {
  final _MemeStatus status;

  _UserTile({this.status = _MemeStatus.Normie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/profilePage'),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage('graphics/man_portrait.jpg'),
          ),
          title: Text(
            'Niklas',
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
              Text('89%',
                  style: TextStyle(fontSize: 24.0, color: Colors.greenAccent)),
            ],
          ),
        ),
      ),
    );
  }
}
