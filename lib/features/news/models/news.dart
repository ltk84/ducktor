class News {
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
    );
  }
}
