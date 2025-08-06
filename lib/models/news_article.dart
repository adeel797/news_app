import '../ui/core/constants.dart';

class NewsArticle {
  final String title;
  final String?
      description; // Nullable since some articles may lack description
  final String url;
  final String? urlToImage; // Nullable for cases where image is missing
  final String? publishedAt; // Optional field for publication date
  final String? sourceName; // Optional field for source name

  NewsArticle({
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    this.sourceName,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? Constants.placeholderImage,
      publishedAt: json['publishedAt'] ?? '',
      sourceName: json['source'] != null ? json['source']['name'] ?? '' : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'source': {'name': sourceName},
    };
  }
}
