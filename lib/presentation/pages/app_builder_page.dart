import 'package:app_builder/presentation/preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_builder_screen.dart';
import '../bloc/component_bloc.dart';

class AppBuilderPage extends StatefulWidget {
  const AppBuilderPage({super.key,});


  @override
  State<AppBuilderPage> createState() => _AppBuilderPageState();
}

class _AppBuilderPageState extends State<AppBuilderPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ComponentBloc(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ComponentBloc, ComponentState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return AppBuilderScreen(state:state);
        });
  }

}
