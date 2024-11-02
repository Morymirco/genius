import 'package:coursenligne/model/model.dart';
import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';

import 'courses-tile.dart';

class Courses extends StatefulWidget {
  const Courses({
    Key ? key
  }): super(key: key);

  @override
  State < Courses > createState() => _CoursesState();
}

class _CoursesState extends State < Courses > {

  List < Course > courses = [];
  List < Lesson > lessons = [];

  @override
  void didChangeDependencies() {
    provideCourses();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: courses.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: getProportionateScreenHeight(25), bottom: getProportionateScreenHeight(15) , left: getProportionateScreenWidth(20) , right: getProportionateScreenWidth(20)  ),
      itemBuilder: (BuildContext context, int index) {
        return CourseTile(course: courses[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: getProportionateScreenHeight(15)
        );
      },
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
        coursePrice: '200K GNF',
        teacherName: 'Mory koulibaly',
        courseDuration: '1h 15m',
        numberOfLessons: '12 leçons',
        courseImage: 'assets/images/ui-ux-design.jpg',
        teacherImage: 'assets/images/samanta-yasamin.jpg',
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
        courseDescription: 'The UI/UX Design Specialization brings a design centric approach to user interface and user experience design, and offers practical, skill-based instruction centered around a visual communications perspective, rather than on one focused on marketing or programming alone.',
        lessons: lessons,
        courseProgressValue: '60'
      )
    );
    courses.add(
      Course(
        title: 'HTML & CSS',
        coursePrice: '100K GNF',
        teacherName: 'Souleymane Diallo',
        courseDuration: '2h 10m',
        numberOfLessons: '20 leçons',
        courseImage: 'assets/images/coding.jpg',
        teacherImage: 'assets/images/alexander.jpg',
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
        courseDescription: 'The UI/UX Design Specialization brings a design centric approach to user interface and user experience design, and offers practical, skill-based instruction centered around a visual communications perspective, rather than on one focused on marketing or programming alone.',
        lessons: lessons,
        courseProgressValue: '45'
      )
    );
    courses.add(
      Course(
        title: 'Digital Marketing',
        coursePrice: '500K GNF',
        teacherName: 'Albert Siba Beavogui',
        courseDuration: '2h 15m',
        numberOfLessons: '15 leçons',
        courseImage: 'assets/images/marketing.jpg',
        teacherImage: 'assets/images/asep.jpg',
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
        courseDescription: 'The UI/UX Design Specialization brings a design centric approach to user interface and user experience design, and offers practical, skill-based instruction centered around a visual communications perspective, rather than on one focused on marketing or programming alone.',
        lessons: lessons,
        courseProgressValue: '80'
      )
    );

    courses.add(
      Course(
        title: 'Design Systemm',
        coursePrice: '600K GNF',
        teacherName: 'Kerfalla Diaby',
        courseDuration: '2h 15m',
        numberOfLessons: '15 leçons',
        courseImage: 'assets/images/design-system.png',
        teacherImage: 'assets/images/alexander.jpg',
        sliderImages: ['assets/images/ui-ux-design.jpg', 'assets/images/coding.jpg', 'assets/images/marketing.jpg'],
        courseDescription: 'The UI/UX Design Specialization brings a design centric approach to user interface and user experience design, and offers practical, skill-based instruction centered around a visual communications perspective, rather than on one focused on marketing or programming alone.',
        lessons: lessons,
        courseProgressValue: '80'
      )
    );
  }
}