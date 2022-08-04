// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class TrendingModel {
  TrendingModel({
    required this.author,
    required this.name,
    required this.avatar,
    required this.url,
    this.description,
    this.language,
    this.languageColor,
    required this.stars,
    required this.forks,
    required this.currentPeriodStars,
    required this.builtBy,
  });

  final String author;
  final String name;
  final String avatar;
  final String url;
  final String? description;
  final String? language;
  final String? languageColor;
  final int stars;
  final int forks;
  final int currentPeriodStars;
  final List<BuiltBy> builtBy;

  factory TrendingModel.fromRawJson(String str) =>
      TrendingModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
        author: json["author"] as String,
        name: json["name"] as String,
        avatar: json["avatar"] as String,
        url: json["url"] as String,
        description: json["description"] as String?,
        language: json["language"] as String?,
        languageColor: json["languageColor"] as String?,
        stars: json["stars"] as int,
        forks: json["forks"] as int,
        currentPeriodStars: json["currentPeriodStars"] as int,
    builtBy: List<BuiltBy>.from((json["builtBy"] as Iterable).map(
          (x) => BuiltBy.fromJson(x as Map<String, dynamic>),
        )),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "name": name,
        "avatar": avatar,
        "url": url,
        "description": description,
        "language": language,
        "languageColor": languageColor,
        "stars": stars,
        "forks": forks,
        "currentPeriodStars": currentPeriodStars,
        "builtBy": List<dynamic>.from(builtBy.map((x) => x.toJson())),
      };
}

class BuiltBy {
  BuiltBy({
    required this.username,
    required this.href,
    required this.avatar,
  });

  final String username;
  final String href;
  final String avatar;

  factory BuiltBy.fromRawJson(String str) =>
      BuiltBy.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory BuiltBy.fromJson(Map<String, dynamic> json) => BuiltBy(
        username: json["username"] as String,
        href: json["href"] as String,
        avatar: json["avatar"] as String,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "href": href,
        "avatar": avatar,
      };
}
