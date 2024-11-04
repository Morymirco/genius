import 'package:flutter/material.dart';
import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/util/util.dart';
import 'cart_body.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';
  
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Mon Panier',
          style: TextStyle(
            color: AppColors.colorTint700,
            fontSize: getProportionateScreenWidth(17)
          ),
        ),
      ),
      body: const CartBody(),
    );
  }
} 