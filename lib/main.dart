import 'package:app_restaurante/screens/auth/pages/login_page.dart';
import 'package:app_restaurante/screens/auth/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home/home_map_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Restaurante',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),

      //define a rota inicial com login
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : const HomeMapScreen(),

      routes: {
        '/home': (context) => const HomeMapScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage()
      },
    );
  }
}
