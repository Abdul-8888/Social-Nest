import 'dart:math';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/posts_model.dart';
import '../api/posts_crud.dart';

class activities extends StatefulWidget {
  @override
  _activitiesState createState() => _activitiesState();
}

class _activitiesState extends State<activities> {
  List<Widget> containers = [];
  List<posts_model> posts = [];
  List<posts_model> added = [];
  bool isLoaded = false;

  @override
  void initState() {
    getPosts();
  }

  TextEditingController Title = TextEditingController();
  TextEditingController Description = TextEditingController();

  getPosts() async {
    containers.clear();
    posts = await post_crud().getPostsList();
    for (var i in posts) {
      if (!added.contains(i)) {
        added.add(i);
        containers.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: newPost(i.title, i.description, i.dateCreated),
        ));
      }
    }
    setState(() {
      if (!posts.isEmpty) isLoaded = true;
    });
  }

  int getPostsId() {
    int maxID = 0;
    for (var i in posts) {
      if (i.id > maxID) {
        maxID = i.id;
      }
    }
    return maxID + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              getPosts();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Posts Refreshed')));
            },
            icon: Icon(Icons.refresh_rounded)),
        title: Text("Daily Posts"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text('Create Post'),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: Title,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.title,
                                    color: Colors.blue,
                                  ),
                                  fillColor: Colors.white,
                                  hintText: 'Title',
                                  label: Text('Title')),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: Description,
                              maxLines: 3,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.description,
                                    color: Colors.blue,
                                  ),
                                  fillColor: Colors.white,
                                  hintText: 'Description',
                                  label: Text('Description')),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ]),
                    ),
                    actions: [
                      ElevatedButton.icon(
                          onPressed: () {
                            posts_model pm = posts_model(
                                id: getPostsId(),
                                title: Title.text,
                                description: Description.text,
                                dateCreated: DateFormat("yyyy-MM-dd hh:mm:ss")
                                    .format(DateTime.now()));
                            posts.add(pm);
                            post_crud().SavePostsList(posts);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('New Post Created.')));
                            getPosts();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: Text('Create'))
                    ],
                  ),
                );
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Visibility(
        visible: isLoaded,
        child: GridView.count(
          crossAxisCount: 2,
          children: containers,
        ),
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Color getRandomColors() {
    List<Color> color = [
      Color.fromRGBO(255, 234, 210, 1),
      Color.fromRGBO(219, 223, 234, 1),
      Color.fromRGBO(175, 211, 226, 1),
      Color.fromRGBO(240, 240, 240, 1),
      Color.fromRGBO(188, 206, 248, 1),
      Color.fromRGBO(196, 221, 255, 1),
      Color.fromRGBO(127, 181, 255, 1),
      Color.fromRGBO(236, 249, 255, 1),
      Color.fromRGBO(236, 249, 255, 1)
    ];
    return (color[Random().nextInt(5)]);
  }

  Container newPost(String Title, String Descrption, String DateCreated) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: getRandomColors(),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                DateCreated,
                softWrap: true,
                style: TextStyle(color: Colors.black, fontSize: 12),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                Title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              )
            ]),
            SizedBox(
              height: 5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                Descrption,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            ])
          ],
        ),
      ),
    );
  }
}
