import 'package:flutter/material.dart';
import 'package:coursenligne/config/theme/theme.dart';
import 'cart_body.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';
  
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mon Panier',
          style: TextStyle(
            color: AppColors.colorTint700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const CartBody(),
    );
  }
} 