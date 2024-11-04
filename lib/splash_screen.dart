import 'dart:async';

import 'package:coursenligne/screen/nav/nav.dart';  // Import de Nav
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";  // Route pour le splash screen

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Délai de 3 secondes avant de naviguer vers la page principale
    Timer(Duration(minutes: 1), () {
      Navigator.pushReplacementNamed(context, Nav.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 400,
            height: 400,
            child: Image.asset("assets/images/logo1.png",width: 100,)),
          Center(
            child:Text("GENIUSCLASS ",style: TextStyle(fontSize: 32),), // Image de splash
          ),

        ],
      ),
    );
  }
}
