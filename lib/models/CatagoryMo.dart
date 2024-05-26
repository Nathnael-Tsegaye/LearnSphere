class Course {
  final String type; // book, video, or title
  final String title;
  final String content;

  Course({
    required this.type,
    required this.title,
    required this.content,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }
}

class CategoryModel {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final List<Course> courses;

  CategoryModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.courses,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var courseList = json['courses'] as List<dynamic>?; 
    List<Course> parsedCourses = courseList != null
        ? courseList.map((courseJson) => Course.fromJson(courseJson)).toList()
        : [];

    return CategoryModel(
      id: json['id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      courses: parsedCourses,
    );
  }
}

