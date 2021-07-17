import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';

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
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {});
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
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):Container(
          child: Column(
            children: [

              //categories
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
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
              Container(
                child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index){
                      return BlogTile(imageUrl: articles[index].urlToImage, title: articles[index].title, desc: articles[index].description);
                    }),
              )
            ],
          ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(right: 14),
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
  BlogTile({required this.imageUrl, required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
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
