import 'package:flutter/material.dart';
import 'package:coursenligne/model/model.dart';
import 'course-tile.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Liste de cours d'exemple
    final List<Course> courses = [
      Course(
        title: "Flutter Avancé",
        teacherName: "John Doe",
        courseDescription: "Apprenez Flutter en profondeur",
        courseImage: "assets/images/course-image-1.jpg",
        teacherImage: "assets/images/profile-image.jpg",
        coursePrice: "99.99€",
        courseDuration: "8h",
        numberOfLessons: "12 leçons",
        courseProgressValue: "0",
      ),
      Course(
        title: "React Native Master",
        teacherName: "Jane Smith",
        courseDescription: "Maîtrisez React Native",
        courseImage: "assets/images/course-image-2.jpg",
        teacherImage: "assets/images/profile-image.jpg",
        coursePrice: "89.99€",
        courseDuration: "10h",
        numberOfLessons: "15 leçons",
        courseProgressValue: "0",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Cours',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 280,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 20 : 0,
                right: 20,
              ),
              child: CourseTile(course: courses[index]),
            ),
          ),
        ),
      ],
    );
  }
}