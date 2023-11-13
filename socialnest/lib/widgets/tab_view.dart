import 'package:carousel_slider/carousel_slider.dart';
import 'package:chattybuzz/api/apis.dart';
import 'package:chattybuzz/utils/widgets_function.dart';
import 'package:chattybuzz/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/article_model.dart';
import '../screens/activities.dart';
import '../screens/article_page.dart';
import '../screens/todo_screen.dart';

class MyTabbedApp extends StatefulWidget {
  @override
  _MyTabbedAppState createState() => _MyTabbedAppState();
}

class _MyTabbedAppState extends State<MyTabbedApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'News'),
            Tab(text: 'Videos'),
            Tab(text: 'Todo'),
            Tab(text: 'Posts'),
          ],
          labelColor: Colors.black,
          labelPadding: EdgeInsets.all(5),
          indicatorWeight: 5,
          unselectedLabelColor: Colors.blue.shade800,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NewsTab(),
          VideosTab(),
          TodoTab(),
          PostsTab(),
        ],
      ),
    );
  }
}

class NewsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double mq = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 18.0, left: 12, right: 12, bottom: 10),
        child: Column(
          children: [
            Center(
              child: const Text(
                'Latest News',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            addVerticalSpace(25),
            Center(
              child: Container(
                height: 180,
                width: mq * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.shade100,
                      blurRadius: 4,
                      offset: Offset(0, 0), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      items: [
                        Image.network('https://picsum.photos/600/300'),
                        Image.network('https://picsum.photos/600/300/?blur=2'),
                        Image.network('https://picsum.photos/id/237/600/300'),
                        Image.network(
                            'https://picsum.photos/seed/picsum/600/300'),
                        Image.network(
                            'https://picsum.photos/600/300?grayscale'),
                        Image.network(
                            'https://picsum.photos/id/870/600/300?grayscale&blur=2'),
                      ],
                      options: CarouselOptions(
                        height: 150,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {},
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            addVerticalSpace(30),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Articles',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600))
                  ],
                ),
                getArticle()
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<Article>> getArticle() {
    return FutureBuilder(
      future: APIs.getArticle(),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        //let's check if we got a response or not
        if (snapshot.hasData) {
          //Now let's make a list of articles
          List<Article>? articles = snapshot.data;
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            //Now let's create our custom List tile
            itemCount: articles!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticlePage(
                                article: articles[index],
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3.0,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          //let's add the height

                          image: DecorationImage(
                              image: NetworkImage(articles[index].urlToImage),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          articles[index].source.name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        articles[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class TodoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return todoscreen();
  }
}

TextEditingController url = TextEditingController();

class VideosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 0.0, left: 12, right: 12, bottom: 10),
        child: YoutubePlayerDemoApp());
  }

  YoutubePlayer Player(String videoUrl) {
    return YoutubePlayer(
      progressColors: ProgressBarColors(playedColor: Colors.blue.shade100),
      controller: YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
    );
  }
}

class PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return activities();
  }
}
