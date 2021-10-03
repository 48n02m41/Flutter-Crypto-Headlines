import 'dart:async';
import 'dart:convert';

import 'package:flutter_rest_test/models/article_model.dart';
import 'package:http/http.dart' as http;

class ArticlesRequest {
  final String url =
      ('https://newsapi.org/v2/everything?q=crypto OR bitcoin OR ethereum&sortBy=publishedAt&pageSize=30&page=1&language=en&apiKey=270f08bcb21a4507a679324d214b469a');

  // API GET
  Future<List<ArticleModel>> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var result = (json.decode(response.body)['articles'] as List)
          // .map((item) => item as Map<String, dynamic>)
          .map((data) => ArticleModel.fromJson(data))
          .toList();

      //print(result);
      return result;
    } else {
      throw Exception('fetchData failed.');
    }
  }
}
