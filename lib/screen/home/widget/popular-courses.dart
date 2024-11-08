import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:coursenligne/screen/courses/courses_list_screen.dart';
import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';

import 'popular-course-tile.dart';

class PopularCourses extends StatefulWidget {
  const PopularCourses({
    Key ? key
  }): super(key: key);

  @override
  State < PopularCourses > createState() => _PopularCoursesState();
}

class _PopularCoursesState extends State < PopularCourses > {

  List < Course > courses = [];
  List < Lesson > lessons = [];

  @override
  void didChangeDependencies() {
    provideCourses();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenHeight(15), left: getProportionateScreenWidth(15), right: getProportionateScreenWidth(15)),
      child: Column(
        children: [
          _popularCoursesText(),
          ListView.separated(
            itemCount: courses.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: getProportionateScreenHeight(20), bottom: getProportionateScreenHeight(15)),
            itemBuilder: (BuildContext context, int index) {
              return PopularCourseTile(course: courses[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: getProportionateScreenHeight(10)
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _popularCoursesText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Cours Populaires',
          style: TextStyle(
            color: AppColors.colorTint700,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenHeight(18)
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesListScreen()));
          },
          child: Text(
            'Voir Tout',
          style: TextStyle(
            color: AppColors.colorTint600,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenHeight(13)
          ),
        ))
      ],
    );
  }

  Future < void > provideCourses() async {
    lessons.add(
      Lesson(
        lessonName: 'UI/UX Design Introduction',
        lessonDuration: '02:10'
      )
    );
    lessons.add(
      Lesson(
        lessonName: 'UI Design Principle',
        lessonDuration: '10:25'
      )
    );
    lessons.add(
      Lesson(
        lessonName: 'Prototyping',
        lessonDuration: '07:55'
      )
    );
    courses.add(
      Course(
        title: 'UI/UX Design',
        coursePrice: '\$150',
        teacherName: 'Mory Koulibaly',
        courseDuration: '1h 15m',
        numberOfLessons: '12 leçons',
        courseImage: 'assets/images/3affiche.jpg',
        teacherImage: 'assets/images/samanta-yasamin.jpg',
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
        courseDescription: 'The UI/UX Design Specialization brings a design centric approach to user interface and user experience design, and offers practical, skill-based instruction centered around a visual communications perspective, rather than on one focused on marketing or programming alone.',
        lessons: lessons
      )
    );
    courses.add(
      Course(
        title: 'HTML & CSS',
        coursePrice: '\$250',
        teacherName: 'Souleymane Diallo',
        courseDuration: '2h 10m',
        numberOfLessons: '20 leçons',
        courseImage: 'assets/images/affiche.jpg',
        teacherImage: 'assets/images/alexander.jpg',
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
        courseDescription: 'The UI/UX Design Specialization brings a design centric approach to user interface and user experience design, and offers practical, skill-based instruction centered around a visual communications perspective, rather than on one focused on marketing or programming alone.',
        lessons: lessons
      )
    );
    courses.add(
      Course(
        title: 'Digital Marketing',
        coursePrice: '\$80',
        teacherName: 'Albert Siba Beavogui',
        courseDuration: '2h 15m',
        numberOfLessons: '15 leçons',
        courseImage: 'assets/images/marketting.jpg',
        teacherImage: 'assets/images/alexander.jpg',
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
        courseDescription: 'The UI/UX Design Specialization brings a design centric approach to user interface and user experience design, and offers practical, skill-based instruction centered around a visual communications perspective, rather than on one focused on marketing or programming alone.',
        lessons: lessons
      )
    );
  }
}