import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];
  String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=afff6a6be928455db57b1a38b188b05c";
}