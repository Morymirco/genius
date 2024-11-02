class Lesson {
  final String? id;
  final String? lessonName;
  final String? lessonDuration;
  final String? description;
  final bool? isCompleted;
  final String? videoUrl;

  Lesson({
    this.id,
    this.lessonName,
    this.lessonDuration,
    this.description,
    this.isCompleted,
    this.videoUrl,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      lessonName: json['lessonName'],
      lessonDuration: json['lessonDuration'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonName': lessonName,
      'lessonDuration': lessonDuration,
      'description': description,
      'isCompleted': isCompleted,
      'videoUrl': videoUrl,
    };
  }
} 