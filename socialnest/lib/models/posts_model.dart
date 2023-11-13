
import 'dart:convert';

List<posts_model> postModelFromJson(String str) => List<posts_model>.from(json.decode(str).map((x) => posts_model.fromJson(x)));

String postModelToJson(List<posts_model> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class posts_model {
    posts_model({
        required this.id,
        required this.title,
        required this.description,   
        required this.dateCreated,
    });

    int id;
    String title;
    String description;
    String dateCreated;   

    factory posts_model.fromJson(Map<String, dynamic> json) => posts_model(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dateCreated: json['dateCreated'],       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "dateCreated":dateCreated,        
    };
}
