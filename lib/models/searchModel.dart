class SearchResult {
  final String title;
  final String description;

  SearchResult({required this.title, required this.description});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'],
      description: json['description'],
    );
  }
}