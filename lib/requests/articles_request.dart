import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ArticlesRequest {
  final String url =
      ('https://newsapi.org/v2/everything?q=crypto&apiKey=270f08bcb21a4507a679324d214b469a');

  // API GET
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var result = json.decode(response.body)['articles'];

      //print(result.toString());
      return result;
    } else {
      throw Exception('fetchData failed.');
    }
  }
}
