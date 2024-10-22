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
Widget buildComponent(Component component, Color color, Function(String) onTapElement) {
  // Check if the child is a GestureDetector
  if (component.child is GestureDetector) {
    final gestureDetector = component.child as GestureDetector;

    // Check if the GestureDetector has a child and if it's Text or Icon
    if (gestureDetector.child is Text) {
      return GestureDetector(
        onTap: () => onTapElement('Text'), // Pass 'Text' as the element type
        child: Text(
          (gestureDetector.child as Text).data!,
          style: (gestureDetector.child as Text).style?.copyWith(color: color) ??
              TextStyle(color: color),
        ),
      );
    } else if (gestureDetector.child is Icon) {
      return GestureDetector(
        onTap: () => onTapElement('Icon'), // Pass 'Icon' as the element type
        child: Icon(
          (gestureDetector.child as Icon).icon,
          color: color, // Apply the icon color
        ),
      );
    } else if (gestureDetector.child is ElevatedButton) {
      return GestureDetector(
        onTap: () => onTapElement('Button'), // Pass 'Button' as the element type
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Button', style: TextStyle(color: Colors.black)),
        ),
      );
    }
  }

  // If not GestureDetector or unsupported child, return the original component's child
  return component.child;
}


