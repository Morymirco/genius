import 'package:flutter/material.dart';
import 'package:coursenligne/screen/home/widget/appbar.dart';

import 'widget/categories.dart';
import 'widget/courses.dart';
import 'widget/popular-courses.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            HomeScreenAppBar(),
            Categories(),
            Courses(),
            PopularCourses()
          ],
        ),
      )
    );
  }
}