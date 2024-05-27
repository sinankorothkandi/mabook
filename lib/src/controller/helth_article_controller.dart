import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:mabook/src/model/helth_model.dart'; // Import your Article model

class HealthArticleController extends GetxController {
  RxList<Article> healthArticles = <Article>[].obs;

  loadArticles() async {
    const String healthArticleUrl =
        'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=977cf2daea6e4b229621a9ba8fe3b765';

    try {
      final http.Response healthArticleResponse =
          await http.get(Uri.parse(healthArticleUrl));

      if (healthArticleResponse.statusCode == 200) {
        final Map<String, dynamic> healthArticleData =
            jsonDecode(healthArticleResponse.body);

        final List<dynamic> articlesJson = healthArticleData['articles'];

        final List<Article> articles = articlesJson.map((articleJson) {
          return Article.fromJson(articleJson);
        }).toList();

        healthArticles.assignAll(articles);
      } else {
        print('Health articles data not fetched');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
