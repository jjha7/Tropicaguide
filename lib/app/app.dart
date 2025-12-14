import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/app_shell.dart';
import '../theme/app_theme.dart';

class TropicaGuideApp extends StatelessWidget {
  const TropicaGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TropicaGuide',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      initialRoute: LoginScreen.route,
      routes: {
        LoginScreen.route: (_) => const LoginScreen(),
        SignupScreen.route: (_) => const SignupScreen(),
        AppShell.route: (_) => const AppShell(),
      },
      onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}
