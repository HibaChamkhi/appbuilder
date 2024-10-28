import 'package:flutter/material.dart';
import 'package:app_builder/presentation/component.dart';
import 'package:app_builder/presentation/style_model.dart';

// This function creates a component based on the type.
Component createComponent(String type, Function(String) onTapElement) {
  // Create a style model based on the type of component
  StyleModel styleModel = StyleModel(
    fontSize: type == 'Text' ? 24.0 : null,
    iconSize: type == 'Icon' ? 40.0 : null,
    padding: type == 'Button' ? const EdgeInsets.all(8.0) : null,
  );

  // Create the component instance and generate its child
  Component component = Component(
    type: type.toLowerCase(),
    styleModel: styleModel,
  );

  // Generate the child widget
  component.createChild();

  return component;
}

// This function builds a widget from a given component.
Widget buildComponent(Component component, Color color, Function(String) onTapElement) {
  // Update the style model of the component with the provided color
  component.styleModel = component.styleModel.copyWith(color: color);

  // Regenerate the child widget based on the updated style
  component.createChild();

  return GestureDetector(
    onTap: () => onTapElement(component.type),
    child: component.child, // Use the generated child widget from the component
  );
}
