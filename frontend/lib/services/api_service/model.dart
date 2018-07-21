class User {
  final String uuid;
  final String name;

  final Image image;

  final double snobOrBobPercentage;
  final double matchPercentage;
  final double enemyPercentage;

  final List<Meme> topMemes;
  final List<Meme> nextMemes;

  final List<User> matches;

  User(
      {this.uuid,
      this.name,
      this.image,
      this.snobOrBobPercentage,
      this.matchPercentage,
      this.enemyPercentage,
      this.topMemes,
      this.nextMemes,
      this.matches});

  factory User.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : User(
            uuid: json["uuid"],
            name: json["name"],
            image: Image.fromJson(json["image"]),
            snobOrBobPercentage: json["snobOrBobPercentage"],
            matchPercentage: json["matchPercentage"],
            enemyPercentage: json["enemyPercentage"],
            topMemes: listFromJson(json["topMemes"],
                (dynamic ele) => Meme.fromJson(ele as Map<String, dynamic>)),
            nextMemes: listFromJson(json["nextMemes"],
                (dynamic ele) => Meme.fromJson(ele as Map<String, dynamic>)),
            matches: listFromJson(json["matches"],
                (dynamic ele) => User.fromJson(ele as Map<String, dynamic>)));
  }
}

class Image {
  final String imgurURL;

  Image({this.imgurURL});

  factory Image.fromJson(Map<String, dynamic> json) {
    return json == null ? null : Image(imgurURL: json["imgurURL"]);
  }
}

class Meme {
  final String uuid;
  final Image image;

  Meme({this.uuid, this.image});

  factory Meme.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Meme(uuid: json["uuid"], image: Image.fromJson(json["image"]));
  }
}

List<T> listFromJson<T>(dynamic list, T fromJson(dynamic json)) {
  if (list == null) {
    return list;
  }

  return (list as List<dynamic>)
      .map((dynamic listElement) => fromJson(listElement))
      .toList();
}
