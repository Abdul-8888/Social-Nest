import 'dart:convert';

import 'package:chattybuzz/models/posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// * SharedPreference key
const postsListKey = 'posts_list';

class post_crud {
  Future<List<posts_model>> getPostsList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString(postsListKey) ?? '[]';
    final jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded
        .map(
          (eachItem) => posts_model.fromJson(eachItem as Map<String, dynamic>),
        )
        .toList();
  }

  void SavePostsList(List<posts_model> posts) async {
    final stringJson = json.encode(posts);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(postsListKey, stringJson);
  }

  bool updatePostsList(List<posts_model> posts, int id, String Title,
      String dateCreated, String description) {
    for (var i in posts) {
      if (i.id == id) {
        i.title = Title;
        i.description = description;
        i.dateCreated = dateCreated;
      }
    }
    SavePostsList(posts);
    return true;
  }
}
