import 'dart:convert';

import 'package:news/modules/home/models/news_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<List<NewsModel>> getNews() async {

    String key = "35034dcfc8b44b3c8bd9768c427b1243";

    Uri uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$key");

    final response = await http.get(uri);

    final List<NewsModel> newslist = [];

    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsModel article = NewsModel(
            title: element['title'],
            description: element['description'],
            content: element["content"],
            imageUrl: element['urlToImage'],
          );
          newslist.add(article);
          return newslist;
        }
      });
    }
    return newslist;
  }
}
