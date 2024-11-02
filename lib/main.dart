import 'package:coursenligne/screen/onboarding/onboarding_page.dart';
import 'package:coursenligne/util/size/size-config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:coursenligne/providers/search_provider.dart';

import 'config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Demande des permissions au démarrage
  await Permission.camera.request();
  await Permission.photos.request();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
          return const OnboardingPage();
        },
      ),
      routes: routes,
    );
  }
}
