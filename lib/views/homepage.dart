import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

    getNews() async{
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
            Text("DNA",style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            Text("News", style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
      body: _loading ? Center(
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              children: [
                //categories
                // ignore: sized_box_for_whitespace
                Container(
                  height: 65,
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return CategoryTile(categoryName: categories[index].categoryName, imageUrl: categories[index].imageUrl);
                      }),
                ),

                //Blogs
                // ignore: avoid_unnecessary_containers
                Container(
                  child: ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return BlogTile(imageUrl: articles[index].urlToImage, title: articles[index].title, desc: articles[index].description);
                      }),
                )
              ],
            ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final imageUrl, categoryName;
  // ignore: use_key_in_widget_constructors
  const CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl, height: 60, width: 120, fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              height: 60, width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                  color: Colors.black26
              ),
              child: Text(categoryName, style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, desc, title;
  // ignore: use_key_in_widget_constructors
  const BlogTile({required this.imageUrl, required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: [
          Image.network(imageUrl),
          Text(title),
          Text(desc)
        ],
      ),
    );
  }
}
