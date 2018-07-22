import 'package:cached_network_image/cached_network_image.dart';
import 'package:elitememer/main.dart';
import 'package:elitememer/services/api_service/api_service.dart';
import 'package:elitememer/services/api_service/model.dart';
import 'package:elitememer/ui/widgets/nav_scaffold.dart';
import 'package:flutter/material.dart';

class MatchesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MatchesPageState();
}

class MatchesPageState extends State<MatchesPage> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();

    service.fetchUserList().then((List<User> userList) {
      setState(() {
        users = userList;
      });
    });
  }

  List<Widget> _buildUserList() {
    final List<Widget> result = [];

    int i = 0;

    users.forEach((User user) {
      i++;

      user.matchPercentage = (83 - ((user.uuid.length % 2 + 1) * 7) * i).toDouble();

      result.add(_UserTile(
        status: (83 - ((user.uuid.length % 2 + 1) * 7) * i) % 5 == 0 ? MemeStatus.MemeSnob : MemeStatus.MemeBob,
        imageUrl: user.image.imgurURL,
        profileName: user.name,
        percentage: '${user.matchPercentage.toInt()}%',
        user: user,
        i: i
      ));

      if (user != users.last) {
        result.add(Divider(
          height: 0.0,
        ));
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return buildNavScaffold(context, ListView(children: _buildUserList()));
  }
}

enum MemeStatus { MemeSnob, MemeBob, Normie }

class _UserTile extends StatelessWidget {
  final MemeStatus status;
  final String profileName;
  final String imageUrl;
  final String percentage;
  final User user;
  final int i;

  _UserTile(
      {this.status = MemeStatus.Normie,
      this.profileName,
      this.imageUrl,
      this.percentage,
      this.user,
      this.i});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        currentI = i;
        navigationTarget = user;
        Navigator.pushNamed(context, '/profilePage');
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 40.0,
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
          title: Text(
            profileName,
            style: TextStyle(fontSize: 26.0),
          ),
          trailing: status != MemeStatus.Normie
              ? Image.asset(
                  status == MemeStatus.MemeSnob
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
