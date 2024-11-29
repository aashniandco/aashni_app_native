import 'package:aashni_app/bloc/login/login_screen_bloc.dart';
import 'package:aashni_app/features/auth/view/auth_screen.dart';
import 'package:aashni_app/features/auth/view/signup_screen.dart';
import 'package:aashni_app/features/categories/view/categories_screen.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aashni + Co',
      theme: AppTheme.lightTheme,
      home: const AuthScreen(),
      //  home:  LoginScreen(),
    );
  }
}
