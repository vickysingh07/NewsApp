class ArticleModel{
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String publishedAt;

  ArticleModel({required this.title, required this.author, required this.content, required this.description, required this.publishedAt, required this.url, required this.urlToImage});
}