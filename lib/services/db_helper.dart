import 'package:flutter/cupertino.dart';
import 'package:flutterapp/models/album.dart';
import 'package:flutterapp/models/comment.dart';
import 'package:flutterapp/models/photo.dart';
import 'package:flutterapp/models/post.dart';
import 'package:flutterapp/models/todo.dart';
import 'package:flutterapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DBhelper {
  static DBhelper _databaseHelper;
  final baseUrl = "https://jsonplaceholder.typicode.com";

  DBhelper._internal();
  factory DBhelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DBhelper._internal();
      print("ilk kez");
      return _databaseHelper;
    } else {
      print("diger");
      return _databaseHelper;
    }
  }

  Future<User> getUserFromUserId(String userId) async {
    var response = await http.get(baseUrl + "/users/" + userId);
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else
      throw Exception("Bağlantı hatası : " + response.statusCode.toString());
  }

  Future<List<Post>> getPostsOfUser(User user) async {
    var response =
        await http.get(baseUrl + "/posts/?userId=" + user.id.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Post.fromJson(map))
          .toList();
    } else
      throw Exception("Bağlantı hatası : " + response.statusCode.toString());
  }

  Future<List<Comment>> getCommentsOfPosts(Post post) async {
    var response =
        await http.get(baseUrl + "/comments/?postId=" + post.id.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Comment.fromJson(map))
          .toList();
    } else
      throw Exception("Bağlantı hatası : " + response.statusCode.toString());
  }

  Future<List<Album>> getAlbumsOfUser(User user) async {
    var response =
        await http.get(baseUrl + "/albums/?userId=" + user.id.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Album.fromJson(map))
          .toList();
    } else
      throw Exception("Bağlantı hatası : " + response.statusCode.toString());
  }

  Future<List<Todo>> getTodosOfUser(User user) async {
    var response =
        await http.get(baseUrl + "/todos/?userId=" + user.id.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Todo.fromJson(map))
          .toList();
    } else
      throw Exception("Bağlantı hatası : " + response.statusCode.toString());
  }

  Future<List<Photo>> getPhotosOfAlbum(Album album) async {
    var response =
        await http.get(baseUrl + "/photos/?albumId=" + album.id.toString());
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((map) => Photo.fromJson(map))
          .toList();
    } else
      throw Exception("Bağlantı hatası : " + response.statusCode.toString());
  }
}
