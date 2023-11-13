class Source {
  String name;

  //Let's create the constructor
  Source({required this.name});

  //Let's create the factory function to map the json
  factory Source.fromJson(Map<String, dynamic> json) {
    String name1 = '';
    if (json['name'] != null) {
      name1 = json['name'] as String;
    } else {
      name1 = '';
    }
    return Source(name: name1);
  }
}
