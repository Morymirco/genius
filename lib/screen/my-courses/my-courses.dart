import 'package:flutter/material.dart';
import 'package:coursenligne/util/util.dart';
import 'my-courses-body.dart';

class MyCoursesScreen extends StatelessWidget {
  static String routeName = '/mycourses';
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCoursesScreenBody()
    );
  }
}