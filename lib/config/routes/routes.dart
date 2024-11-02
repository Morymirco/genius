import 'package:coursenligne/screen/home/home-body.dart';
import 'package:coursenligne/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:coursenligne/Admin/sign/register.dart';
import 'package:coursenligne/Admin/sign/login.dart';
import 'package:coursenligne/screen/notification/notification_screen.dart';
import 'package:coursenligne/screen/cart/cart_screen.dart';
import 'package:coursenligne/screen/auth/login_screen.dart';
import 'package:coursenligne/screen/auth/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => const HomeScreenBody(),
  '/register': (context) => const RegisterPage(),
  '/login': (context) => const LoginPage(),
  
  '/profile': (context) => const MonProfil(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
};