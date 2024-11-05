import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  Future<bool> _precacheImage(BuildContext context) async {
    try {
      await precacheImage(const AssetImage("assets/images/logo.jpg"), context);
      return true;
    } catch (e) {
      print('Erreur lors du chargement du logo: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _precacheImage(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF43BCCD),
              ),
            ),
          );
        }

        return Image.asset(
          "assets/images/logo.jpg",
          width: 100,
          errorBuilder: (context, error, stackTrace) {
            print('Erreur d\'affichage du logo: $error');
            return const Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            );
          },
        );
      },
    );
  }
} 