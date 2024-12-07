import 'package:aashni_app/bloc/text_change/state/text_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }

void main() {
  runApp(
    BlocProvider(
      create: (context) => TextBloc(),
      child: const MyApp(),
    ),
  );
}