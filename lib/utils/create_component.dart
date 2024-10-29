// Updated Code

import 'package:flutter/material.dart';
import '../presentation/type_model.dart';


SelectedElement updateComponent(SelectedElement selectedElement, {Widget? newWidget}) {
  Widget updatedWidget = newWidget ?? selectedElement.widget;
  return SelectedElement(
    type: selectedElement.type,
    widget: updatedWidget,
    isLayout: selectedElement.isLayout,
  );
}

Widget buildComponent(Widget component) {
  return component;
}

Widget mapParamsToWidget(Map<String, dynamic> params) {
  // Check if 'text' exists in the params, this means we are dealing with a Text widget
  if (params.containsKey('text')) {
    return Text(
      params['text'], // The text to display
      style: TextStyle(
        color: params['color'] ?? Colors.black, // The color of the text
      ),
    );
  }

  // Check if we are dealing with an Icon by checking 'size' or 'color'
  if (params.containsKey('icon') || params.containsKey('size')) {
    return Icon(
      params['icon'] ?? Icons.star, // Default to Icons.star if no icon is provided
      color: params['color'] ?? Colors.black, // The color of the icon
      size: params['size'] ?? 24.0, // Default size to 24.0
    );
  }

  // Default fallback widget if no valid params were found
  return const SizedBox.shrink(); // An empty widget
}




