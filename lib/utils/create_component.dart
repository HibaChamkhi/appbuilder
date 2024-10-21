import 'package:flutter/material.dart';

import '../presentation/component.dart';

// This function creates a component based on the type.
Component createComponent(String type, Color elementColor, Function(String) onTapElement) {
  Widget child;

  if (type == "Text") {
    child = Text(
      'This is some text!',
      style: TextStyle(color: elementColor, fontSize: 24, fontWeight: FontWeight.bold),
    );
  } else if (type == "Button") {
    child = ElevatedButton(
      onPressed: () {},
      child: const Text('Button', style: TextStyle(color: Colors.black)),
    );
  } else {
    child = const Icon(
      Icons.star,
      size: 40,
      color: Colors.white,
    );
  }

  return Component(
    child: GestureDetector(
      onTap: () => onTapElement(type),
      child: child,
    ),
  );
}

// This function builds a widget from a given component.
Widget buildComponent(Component component) {
  return component.child;
}
