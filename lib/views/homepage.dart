import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/category_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
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
      body: Container(
          child: Column(
            children: [
              Container(
                height: 65,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(categoryName: categories[index].categoryName, imageUrl: categories[index].imageUrl);
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
    return Container(
      child: Stack(
        children: [
          Image.network(imageUrl, height: 60, width: 120,),
        ],
      ),
    );
  }
}

