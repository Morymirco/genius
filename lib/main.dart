import 'package:coursenligne/screen/splash/splash_screen.dart';
import 'package:coursenligne/util/size/size-config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser Firebase
  await Firebase.initializeApp();
  
  // Demande des permissions au démarrage
  await Permission.camera.request();
  await Permission.photos.request();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          SizeConfig.init(context);
          return const SplashScreen();
        },
      ),
      routes: routes,
    );
  }
}
