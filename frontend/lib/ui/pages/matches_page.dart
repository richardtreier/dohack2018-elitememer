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
            backgroundImage:
                NetworkImage('https://randomuser.me/api/portraits/men/3.jpg'),
          ),
          title: Text(
            'Niklas',
            style: TextStyle(fontSize: 26.0),
          ),
          trailing: status != _MemeStatus.Normie
              ? Image.network(
                  status == _MemeStatus.MemeSnob
                      ? 'https://emojipedia-us.s3.amazonaws.com/thumbs/320/facebook/138/man-in-tuxedo_1f935.png'
                      : 'https://emojipedia-us.s3.amazonaws.com/thumbs/320/facebook/138/male-farmer_1f468-200d-1f33e.png',
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
              Padding(
                padding: EdgeInsets.only(right: 7.0, left: 7.0),
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
