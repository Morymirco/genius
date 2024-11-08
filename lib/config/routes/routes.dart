import 'package:coursenligne/Admin/sign/login.dart';
import 'package:coursenligne/Admin/sign/register.dart';
import 'package:coursenligne/screen/auth/forgot_password_screen.dart';
import 'package:coursenligne/screen/auth/login_screen.dart';
import 'package:coursenligne/screen/auth/otp_screen.dart';
import 'package:coursenligne/screen/auth/register_screen.dart';
import 'package:coursenligne/screen/cart/card_info_screen.dart';
import 'package:coursenligne/screen/cart/cart_screen.dart';
import 'package:coursenligne/screen/cart/checkout_screen.dart';
import 'package:coursenligne/screen/cart/orange_money_screen.dart';
import 'package:coursenligne/screen/course-detail/course-detail.dart';
import 'package:coursenligne/screen/home/home-body.dart';
import 'package:coursenligne/screen/my-courses/my-courses.dart';
import 'package:coursenligne/screen/notification/notification_screen.dart';
import 'package:coursenligne/screen/profile/edit_profile_page.dart';
import 'package:coursenligne/screen/profile/profile_screen.dart';
import 'package:coursenligne/screen/search/search_screen.dart';
import 'package:coursenligne/screen/settings/settings_screen.dart';
import 'package:coursenligne/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomeScreenBody(),
  '/register': (context) => const RegisterPage(),
  '/login': (context) => const LoginPage(),
  '/profile': (context) => const MonProfil(),
  '/edit-profile': (context) => const EditProfilePage(),
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
  SearchScreen.routeName: (context) => const SearchScreen(),
  CheckoutScreen.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments as double?;
    return CheckoutScreen(totalAmount: args ?? 0.0);
  },
  CardInfoScreen.routeName: (context) {
    final args = ModalRoute.of(context)?.settings.arguments as double?;
    return CardInfoScreen(amount: args ?? 0.0);
  },
  OrangeMoneyScreen.routeName: (context) => OrangeMoneyScreen(
    amount: ModalRoute.of(context)!.settings.arguments as double,
  ),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
};
