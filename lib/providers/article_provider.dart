import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_test/requests/articles_request.dart';

class ArticleDataProvider with ChangeNotifier {
  ArticlesRequest articleRequest = ArticlesRequest();

  var result;
  bool loading = false;

  getArticleData(context) async {
    loading = true;
    result = await articleRequest.fetchData();
    loading = false;

    notifyListeners();
  }
}
