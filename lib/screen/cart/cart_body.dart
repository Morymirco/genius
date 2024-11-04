import 'package:coursenligne/config/theme/theme.dart';
import 'package:flutter/material.dart';

import 'widgets/cart_item.dart';

class CartBody extends StatelessWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: const [
              CartItem(
                title: "Flutter Avancé",
                instructor: "Mory koulibaly",
                price: "100 milles GNF",
                imageUrl: "assets/images/marketting.jpg",
              ),
              CartItem(
                title: "React Native Master",
                instructor: "Thierno Suleymane ",
                price: "500 milles GNF",
                imageUrl: "assets/images/ui-ux-design.jpg",
              ),
            ],
          ),
        ),
        _buildBottomBar(context),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorTint700,
                  ),
                ),
                Text(
                  "600 milles GNF",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Action pour le paiement
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:  Text(
                  "Payer maintenant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 