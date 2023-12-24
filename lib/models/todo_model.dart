
import 'dart:convert';

List<todomodel> postModelFromJson(String str) => List<todomodel>.from(json.decode(str).map((x) => todomodel.fromJson(x)));

String postModelToJson(List<todomodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class todomodel {
    todomodel({
        required this.id,
        required this.title,
        required this.description,
        required this.status,
        required this.deadline,
    });

    int id;
    String title;
    String description;
    String deadline;
    String status;

    factory todomodel.fromJson(Map<String, dynamic> json) => todomodel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        deadline: json['deadline'],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "deadline":deadline,
        "status": status,
    };
}
