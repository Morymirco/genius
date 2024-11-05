import 'package:coursenligne/screen/nav/nav.dart';
import 'package:coursenligne/screen/splash/splash_screen.dart';
import 'package:coursenligne/util/size/size-config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'config/routes/routes.dart';
import 'services/course_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Erreur d\'initialisation Firebase: $e');
  }
  
  // Initialiser les cours par défaut
  final courseService = CourseService();
  await courseService.initializeDefaultCourses();
  
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
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              
              if (snapshot.hasData && snapshot.data != null) {
                // L'utilisateur est connecté, aller à la page d'accueil
                return const Nav();
              }
              
              // L'utilisateur n'est pas connecté, afficher le splash screen
              return const SplashScreen();
            },
          );
        },
      ),
      routes: routes,
    );
  }
}
