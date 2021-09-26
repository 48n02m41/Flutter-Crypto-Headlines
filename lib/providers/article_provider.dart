import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_test/models/article_model.dart';
import 'package:flutter_rest_test/requests/articles_request.dart';

class ArticleDataProvider with ChangeNotifier {
  ArticlesRequest articleRequest = ArticlesRequest();

  late List<ArticleModel> result = List.empty();
  bool loading = false;

  getArticleData(context) async {
    loading = true;
    result = await articleRequest.fetchData();
    loading = false;

    notifyListeners();
  }
}
