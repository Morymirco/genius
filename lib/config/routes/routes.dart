import 'package:coursenligne/Admin/sign/login.dart';
import 'package:coursenligne/Admin/sign/register.dart';
import 'package:coursenligne/screen/auth/forgot_password_screen.dart';
import 'package:coursenligne/screen/auth/login_screen.dart';
import 'package:coursenligne/screen/auth/otp_screen.dart';
import 'package:coursenligne/screen/auth/register_screen.dart';
import 'package:coursenligne/screen/cart/cart_screen.dart';
import 'package:coursenligne/screen/course-detail/course-detail.dart';
import 'package:coursenligne/screen/home/home-body.dart';
import 'package:coursenligne/screen/my-courses/my-courses.dart';
import 'package:coursenligne/screen/notification/notification_screen.dart';
import 'package:coursenligne/screen/profile/profile_screen.dart';
import 'package:coursenligne/screen/splash/splash_screen.dart';
import 'package:coursenligne/screen/course-viewer/course_viewer_screen.dart';
import 'package:coursenligne/screen/search/search_screen.dart';
import 'package:coursenligne/screen/courses/courses_list_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomeScreenBody(),
  '/register': (context) => const RegisterPage(),
  '/login': (context) => const LoginPage(),
  
  '/profile': (context) => const MonProfil(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  CourseDetailScreen.routeName: (context) => const CourseDetailScreen(),
  MyCoursesScreen.routeName: (context) => const MyCoursesScreen(),
  '/splash': (context) => const SplashScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  OTPScreen.routeName: (context) => const OTPScreen(
    phoneNumber: '',
    verificationId: '',
  ),
  // CourseViewerScreen.routeName: (context) => const CourseViewerScreen(
  //   course: null,
  //   initialLessonIndex: 0,
  // ),
  SearchScreen.routeName: (context) => const SearchScreen(),
  CoursesListScreen.routeName: (context) => const CoursesListScreen(),
};
