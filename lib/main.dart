import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_test/providers/article_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.indigo,
            ),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(title: const Text('CryptoHeadlines')),
                body: Container(
                    padding: const EdgeInsets.all(8),
                    child: Consumer<ArticleDataProvider>(
                        builder: (context, data, child) {
                      if (data.result.isNotEmpty && data.loading == false) {
                        return ListView.builder(
                            itemCount: data.result.length,
                            itemBuilder: (BuildContext context, int index) {
                              // return Text(data.result[index].title);
                              return Center(
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(children: [
                                        Image.network(
                                          data.result[index].urlToImage,
                                          errorBuilder: (context, exception,
                                                  stackTrack) =>
                                              const Text(""),
                                          isAntiAlias: true,
                                        ),
                                        ListTile(
                                          title: Text(data.result[index].title),
                                          subtitle: Text(
                                              data.result[index].description),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.read_more),
                                            onPressed: () {
                                              _launchURL(
                                                  "" + data.result[index].url);
                                            },
                                          ),
                                        )
                                      ])));
                            });
                      } else {
                        return SizedBox(
                            child: Center(
                                child: Transform.scale(
                                    scale: 4,
                                    child: const CircularProgressIndicator())));
                      }
                    })))));
  }

  void _launchURL(String url) async => await canLaunch(url)
      ? await launch(url, forceWebView: true, enableJavaScript: true)
      : throw 'Could not launch $url';
}
