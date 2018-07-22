class User {
  final String uuid;
  final String name;

  final RichardsImage image;

  final double snobOrBobPercentage;
  double matchPercentage;
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
            image: RichardsImage.fromJson(json["avatar"]),
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

class RichardsImage {
  final String imgurURL;

  RichardsImage({this.imgurURL});

  factory RichardsImage.fromJson(Map<String, dynamic> json) {
    return json == null ? null : RichardsImage(imgurURL: json["imgurURL"]);
  }
}

class Meme {
  final String uuid;
  final RichardsImage image;

  Meme({this.uuid, this.image});

  factory Meme.fromJson(Map<String, dynamic> json) {
    return json == null
        ? null
        : Meme(uuid: json["uuid"], image: RichardsImage.fromJson(json["image"]));
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
