import 'package:coursenligne/util/util.dart';
import 'package:flutter/material.dart';

import 'my-courses-body.dart';

class MyCoursesScreen extends StatelessWidget {
  static String routeName = '/mycourses';
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig.init(context);
    return Scaffold(
      body: MyCoursesScreenBody()
    );
  }
}