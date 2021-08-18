
import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/helper/widget.dart';

class CategoryNews extends StatefulWidget {

  final String newsCategory;

  // ignore: use_key_in_widget_constructors
  const CategoryNews({required this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  // ignore: prefer_typing_uninitialized_variables
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getCategorieNews();
    // TODO: implement initState
    super.initState();
  }

  void getCategorieNews() async {
    NewsForCategorie categorienews = NewsForCategorie();
    await categorienews.getNewsForCategory(widget.newsCategory);
    newslist = categorienews.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const Text(
              "Flutter",
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            const Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.share,)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading ? const Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        // ignore: avoid_unnecessary_containers
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          child: ListView.builder(
              itemCount: newslist.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return NewsTile(
                  imgUrl: newslist[index].urlToImage ?? "",
                  title: newslist[index].title ?? "",
                  desc: newslist[index].description ?? "",
                  content: newslist[index].content ?? "",
                  posturl: newslist[index].url ?? "",
                );
              }),
        ),
      ),
    );
  }
}