import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_test/providers/article_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

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
                    if (data.result.isNotEmpty && data.loading == false) {
                      //print(data.result.runtimeType);
                      // return const Text(
                      //     'Data successfully loaded. Placeholder.');
                      return ListView.builder(
                        itemCount: data.result.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(data.result[index].title ?? '');
                        },
                      );
                    } else {
                      return const Text('Loading Data');
                    }
                  },
                ),
              ))),
    );
  }
}
