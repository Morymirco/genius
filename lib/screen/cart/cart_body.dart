import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/screen/cart/checkout_screen.dart';
import 'package:coursenligne/services/auth_service.dart';
import 'package:coursenligne/services/firestore_service.dart';
import 'package:flutter/material.dart';

import 'widgets/cart_item.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  bool _isLoading = true;
  List<dynamic> _cartItems = [];
  double _totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final userDoc = await _firestoreService.getUserProfile(user.uid);
        final userData = userDoc.data() as Map<String, dynamic>?;
        final cart = List<String>.from(userData?['cart'] ?? []);

        // Charger les détails de chaque cours dans le panier
        final courses = await _firestoreService.getCoursesById(cart);
        
        if (mounted) {
          setState(() {
            _cartItems = courses;
            _totalAmount = courses.fold(0, (sum, course) {
              final price = course['coursePrice'] as String;
              final numericPrice = double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
              return sum + numericPrice;
            });
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Erreur lors du chargement du panier: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _removeFromCart(String courseId) async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        await _firestoreService.removeFromCart(courseId);
        await _loadCartItems(); // Recharger le panier
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cours retiré du panier'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      print('Erreur lors de la suppression du cours: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la suppression du cours'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Votre panier est vide',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ajoutez des cours pour commencer',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final course = _cartItems[index];
              return CartItem(
                title: course['title'] ?? '',
                instructor: course['teacherName'] ?? '',
                price: course['coursePrice'] ?? '',
                imageUrl: course['courseImage'] ?? '',
                onDelete: () => _removeFromCart(course['id']),
              );
            },
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
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorTint700,
                  ),
                ),
                Text(
                  "${_totalAmount.toStringAsFixed(0)} GNF",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF43BCCD),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _cartItems.isEmpty ? null : () {
                  Navigator.pushNamed(
                    context,
                    CheckoutScreen.routeName,
                    arguments: _totalAmount,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A3085),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
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