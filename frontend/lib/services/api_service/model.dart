class User {
  final String uuid;
  final String name;

  final Image image;

  final double snobOrBobPercentage;
  final double matchPercentage;
  final double enemyPercentage;

  final List<Meme> topMemes;

  User(
      {this.uuid,
      this.name,
      this.image,
      this.snobOrBobPercentage,
      this.matchPercentage,
      this.enemyPercentage,
      this.topMemes});

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
            topMemes: json["topMemes"] == null
                ? null
                : (json["topMemes"] as List<Map<String, dynamic>>)
                    .map((ele) => Meme.fromJson(ele)));
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
