import 'source_model.dart';

class Article {
  Source source;

  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content = '';

  //Now let's create the constructor
  Article(
      {required this.source,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  //And now let's create the function that will map the json into a list
  factory Article.fromJson(Map<String, dynamic> json) {
    String content1 = '';
    String title1 = '';
    String description1 = '';
    String url1 = '';
    String urlToImage1 = '';
    String publishedAt1 = '';
    //String content1 = '';

    if (json['content'] != null) {
      content1 = json['content'] as String;
    } else {
      content1 = '';
    }
    if (json['title'] != null) {
      title1 = json['title'] as String;
    } else {
      title1 = '';
    }
    if (json['description'] != null) {
      description1 = json['description'] as String;
    } else {
      description1 = '';
    }
    if (json['url'] != null) {
      url1 = json['url'] as String;
    } else {
      url1 = '';
    }
    if (json['urlToImage'] != null) {
      urlToImage1 = json['urlToImage'] as String;
    } else {
      urlToImage1 = '';
    }
    if (json['publishedAt'] != null) {
      publishedAt1 = json['publishedAt'] as String;
    } else {
      publishedAt1 = '';
    }
    return Article(
      source: Source.fromJson(json['source']),
      title: title1,
      description: description1,
      url: url1,
      urlToImage: urlToImage1,
      publishedAt: publishedAt1,
      content: content1,
    );
  }
}
