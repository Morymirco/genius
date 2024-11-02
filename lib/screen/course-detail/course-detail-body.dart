 import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:coursenligne/util/util.dart';
import 'package:coursenligne/widget/button/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widget/course-information.dart';
import 'widget/course-lessons.dart';
import 'widget/image-slider.dart';

 class CourseDetailScreenBody extends StatelessWidget {
   const CourseDetailScreenBody({
     Key ? key,
     this.course
   }): super(key: key);

   final Course ? course;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
         centerTitle: true,
         automaticallyImplyLeading: false,
         title: Text(
           'Details du Cours',
           style: TextStyle(
             color: AppColors.colorTint700,
             fontSize: getProportionateScreenWidth(17)
           ),
         ),
         backgroundColor: Colors.white,
         elevation: 0,
         leading: _back(context),
         actions: [
           _bookmark()
         ],
       ),
       body: SafeArea(
         child: Stack(
           children: [
             ListView(
               physics: BouncingScrollPhysics(),
               children: [
                 ImagesSlider(course: course),
                 CourseInformation(course: course),
                 CourseLessons(course: course, )
               ],
             ),
             Align(
               alignment: Alignment.bottomCenter,
               child: Container(
                 margin: EdgeInsets.all(15),
                 child: GeneralButton(
                   text: 'S\'inscrire maintentant!',
                   onPressed: () {},
                   activeButton: true
                 ),
               ),
             )
           ],
         ),
       )
     );
   }

   Widget _bookmark() {
     return Container(
       height: getProportionateScreenWidth(40),
       width: getProportionateScreenWidth(40),
       margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
       decoration: BoxDecoration(
         shape: BoxShape.circle,
         border: Border.all(color: AppColors.colorTint400)
       ),
       child: IconButton(
         icon: SvgPicture.asset(
           'assets/icons/bookmark.svg',
           color: AppColors.colorTint600,
           width: getProportionateScreenWidth(25),
           height: getProportionateScreenWidth(25),
         ),
         onPressed: () async {}
       ),
     );
   }

   Widget _back(BuildContext context) {
     return Container(
       height: getProportionateScreenWidth(40),
       width: getProportionateScreenWidth(40),
       margin: EdgeInsets.only(left: getProportionateScreenWidth(15)),
       decoration: BoxDecoration(
         shape: BoxShape.circle,
         border: Border.all(color: AppColors.colorTint400)
       ),
       child: IconButton(         
         icon: Icon(
           Icons.arrow_back_ios,
           color: AppColors.colorTint600,
           size: 18,
         ),
         onPressed: () async {
           Navigator.pop(context);
         }
       ),
     );
   }
 }