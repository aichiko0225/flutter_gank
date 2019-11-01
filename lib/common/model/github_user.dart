import 'dart:convert';

class User {
  String login;
  int id;
  String avatarUrl;
  String url;
  String email;
  String bio;
  String location;
  String blog;
  String name;
  String token;

  User.fromJson(Map userMap) {
    login = userMap['login'];
    id = userMap['id'];
    avatarUrl = userMap['avatar_url'];
    url = userMap['url'];
    email = userMap['email'];
    bio = userMap['bio'];
    location = userMap['location'];
    blog = userMap['blog'];
    name = userMap['name'];
    token = userMap['token'];
  }

  String toJson() {
    Map<String, dynamic> userMap = new Map();
    userMap['login'] = login;
    userMap['id'] = id;
    userMap['avatar_url'] = avatarUrl;
    userMap['url'] = url;
    userMap['email'] = email;
    userMap['bio'] = bio;
    userMap['location'] = location;
    userMap['blog'] = blog;
    userMap['name'] = name;
    userMap['token'] = token;
    return json.encode(userMap);
  }

  String get userDesc => bio ?? blog ?? email;

  String get userName => name ?? login;

  bool get isLogin => token != null && token.isNotEmpty;
}
