import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_test/providers/article_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

// State
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final ArticleDataProvider articleDataProvider = ArticleDataProvider();

  @override
  Widget build(BuildContext context) {
    articleDataProvider.getArticleData(context); // launch GET request.

    return ChangeNotifierProvider<ArticleDataProvider>(
      create: (context) => articleDataProvider,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(title: const Text('CryptoHeadlines')),
              body: Container(
                padding: const EdgeInsets.all(16),
                child: Consumer<ArticleDataProvider>(
                  builder: (context, data, child) {
                    if (data.result == null || data.loading == false) {
                      //print(data.result);
                      return const Text(
                          'Data successfully loaded. Placeholder.');
                    } else {
                      return const Text('Loading Data');
                    }
                    // return Text('Placeholder');
                  },
                ),
              ))),
    );
  }
}
