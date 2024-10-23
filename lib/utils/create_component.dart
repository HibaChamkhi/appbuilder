import 'package:flutter/material.dart';

import '../presentation/component.dart';

// This function creates a component based on the type.
Component createComponent(
    Widget type,
    ) {



  return Component(
    child: GestureDetector(
      // onTap: () => onTapElement(type),
      child: type,
    ),
  );
}

Widget buildComponent(Widget component) {
  return component;
}
