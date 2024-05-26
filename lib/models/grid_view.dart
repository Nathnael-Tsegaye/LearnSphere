class Chapter {
  final String type; // book, video, or title
  final String title;
  final String content; // This can be URL for video/book or just text for title

  Chapter({
    required this.type,
    required this.title,
    required this.content,
  });
}

class PopularModel {
   final int id;
  final String imageUrl;
  final String title;
  final double price;
  final String description;
  final List<Chapter> chapters;

  PopularModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    required this.chapters,
  });

  factory PopularModel.fromJson(Map<String, dynamic> json) {
    List<Chapter> parsedChapters = [];
    if (json['chapters'] != null) {
      for (var chapterJson in json['chapters']) {
        parsedChapters.add(
          Chapter(
            type: chapterJson['type'] ?? '',
            title: chapterJson['title'] ?? '',
            content: chapterJson['content'] ?? '',
          ),
        );
      }
    }

    return PopularModel(
      id: json['id'],
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      price: json['price']?? '',
      description: json['description'] ?? '',
      chapters: parsedChapters,
    );
  }
}