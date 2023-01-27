import 'package:ducktor/features/news/models/news.dart';

class NewsResponse {
  final List<News> data;

  NewsResponse({
    required this.data,
  });

  factory NewsResponse.fromMap(Map<String, dynamic> map) {
    final List<News> news =
        (map['data'] as List).map((e) => News.fromMap(e)).toList();

    return NewsResponse(data: news);
  }
}
