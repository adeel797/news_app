import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';
import '../ui/core/constants.dart';

class NewsService {
  Future<List<NewsArticle>> fetchNews(
      {String? query, String? category, int page = 1}) async {
    if (Constants.newsApiKey.isEmpty) {
      throw Exception('News API key is missing');
    }

    final uri = Uri.parse(
      '${Constants.newsApiBaseUrl}/everything?q=${query ?? "world"}${category != null ? "&category=$category" : ""}&page=$page&apiKey=${Constants.newsApiKey}',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List articles = data['articles'];
        return articles.map((json) => NewsArticle.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching world news: $e');
    }
  }
}
