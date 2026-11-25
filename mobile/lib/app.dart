import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'core/theme/app_theme.dart';
import 'features/admin/category_admin_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/habits/habit_detail_screen.dart';
import 'features/habits/habit_form_screen.dart';
import 'features/shell/main_shell.dart';
import 'features/splash/splash_screen.dart';

class RutinAgiApp extends StatelessWidget {
  const RutinAgiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rutin Ağı',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.home: (context) => const MainShell(),
        AppRoutes.habitDetail: (context) => const HabitDetailScreen(),
        AppRoutes.habitForm: (context) => HabitFormScreen(
              isEditing: ModalRoute.of(context)?.settings.arguments == true,
            ),
        AppRoutes.categories: (context) => const CategoryAdminScreen(),
      },
    );
  }
}
