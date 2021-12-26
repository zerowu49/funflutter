import 'dart:convert';
import 'package:funflutter/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = 'e473b743acd14a788134dda221c18c7d';
  static final String _category = 'business';
  static final String _country = 'id';

  /// https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=e473b743acd14a788134dda221c18c7d

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl +
        "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
