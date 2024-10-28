import 'package:app_builder/presentation/bloc/component_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/app_builder_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ComponentBloc(),
      child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AppBuilderScreen(),
      )),
    );
  }
}

