import 'package:flutter/material.dart';
import 'package:lab_2/screens/home_page.dart';
import 'package:lab_2/screens/lock_page.dart';
import 'package:lab_2/screens/login_page.dart';
import 'package:lab_2/screens/profile_page.dart';
import 'package:lab_2/screens/register_page.dart';
import 'package:lab_2/theme/app_theme.dart';



void main() => runApp(const LockApp());

class LockApp extends StatelessWidget {
  const LockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Lock',
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/home': (_) => const HomePage(),
        '/profile': (_) => const ProfilePage(),
        '/lock': (_) => const LockPage(lockName: '',),
      },
    );
  }
}
