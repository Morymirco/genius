import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:coursenligne/services/auth_service.dart';
import 'package:coursenligne/services/firestore_service.dart';
import 'package:coursenligne/util/util.dart';
import 'package:coursenligne/widget/button/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widget/course-information.dart';
import 'widget/course-lessons.dart';
import 'widget/image-slider.dart';

class CourseDetailScreenBody extends StatefulWidget {
  final Course? course;

  const CourseDetailScreenBody({
    Key? key,
    this.course,
  }) : super(key: key);

  @override
  State<CourseDetailScreenBody> createState() => _CourseDetailScreenBodyState();
}

class _CourseDetailScreenBodyState extends State<CourseDetailScreenBody> {
  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  bool _isInCart = false;
  bool _isLoading = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfInCart();
    _checkIfFavorite();
  }

  Future<void> _checkIfInCart() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final userDoc = await _firestoreService.getUserProfile(user.uid);
        final userData = userDoc.data() as Map<String, dynamic>?;
        final cart = List<String>.from(userData?['cart'] ?? []);
        
        if (mounted) {
          setState(() {
            _isInCart = cart.contains(widget.course?.title);
          });
        }
      }
    } catch (e) {
      print('Erreur lors de la vérification du panier: $e');
    }
  }

  Future<void> _toggleCart(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = _authService.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez vous connecter pour gérer votre panier'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final userDoc = await _firestoreService.getUserProfile(user.uid);
      final userData = userDoc.data() as Map<String, dynamic>?;
      final cart = List<String>.from(userData?['cart'] ?? []);

      if (_isInCart) {
        // Retirer du panier
        cart.remove(widget.course?.title);
        await _firestoreService.updateUserProfile(user.uid, {
          'cart': cart,
          'updatedAt': DateTime.now().toIso8601String(),
        });

        if (mounted) {
          setState(() {
            _isInCart = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cours retiré du panier'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } else {
        // Ajouter au panier
        cart.add(widget.course?.title ?? '');
        await _firestoreService.updateUserProfile(user.uid, {
          'cart': cart,
          'updatedAt': DateTime.now().toIso8601String(),
        });

        if (mounted) {
          setState(() {
            _isInCart = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cours ajouté au panier'),
              backgroundColor: Color(0xFF43BCCD),
            ),
          );
        }
      }
    } catch (e) {
      print('Erreur lors de la gestion du panier: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la gestion du panier'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _checkIfFavorite() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        final userDoc = await _firestoreService.getUserProfile(user.uid);
        final userData = userDoc.data() as Map<String, dynamic>?;
        final favorites = List<String>.from(userData?['favorites'] ?? []);
        
        if (mounted) {
          setState(() {
            _isFavorite = favorites.contains(widget.course?.title);
          });
        }
      }
    } catch (e) {
      print('Erreur lors de la vérification des favoris: $e');
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      final user = _authService.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez vous connecter pour gérer vos favoris'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final userDoc = await _firestoreService.getUserProfile(user.uid);
      final userData = userDoc.data() as Map<String, dynamic>?;
      final favorites = List<String>.from(userData?['favorites'] ?? []);

      setState(() {
        if (_isFavorite) {
          favorites.remove(widget.course?.title);
        } else {
          favorites.add(widget.course?.title ?? '');
        }
        _isFavorite = !_isFavorite;
      });

      await _firestoreService.updateUserProfile(user.uid, {
        'favorites': favorites,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFavorite ? 'Ajouté aux favoris' : 'Retiré des favoris'),
            backgroundColor: _isFavorite ? const Color(0xFF43BCCD) : Colors.orange,
          ),
        );
      }
    } catch (e) {
      print('Erreur lors de la gestion des favoris: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la gestion des favoris'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
                ImagesSlider(course: widget.course),
                CourseInformation(course: widget.course),
                CourseLessons(course: widget.course)
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: GeneralButton(
                        text: _isInCart ? 'Retirer du panier' : 'Ajouter au panier',
                        onPressed: _isLoading ? null : () => _toggleCart(context),
                        activeButton: true,
                        icon: _isLoading 
                            ? null 
                            : (_isInCart ? Icons.remove_shopping_cart : Icons.shopping_cart_outlined),
                        iconSize: 20,
                        iconSpacing: 8,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
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
        icon: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite ? Colors.red : AppColors.colorTint600,
          size: getProportionateScreenWidth(20),
        ),
        onPressed: _toggleFavorite,
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