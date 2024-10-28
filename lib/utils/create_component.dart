// Updated Code

import 'package:flutter/material.dart';
import '../presentation/type_model.dart';

// Utility functions
Widget wrapWithGestureDetector(Widget widget, Function onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: widget,
  );
}

SelectedElement createComponent(
    SelectedElement selectedElement, Function(SelectedElement)? selectElement) {
  Widget wrappedWidget = wrapWithGestureDetector(selectedElement.widget, () {
    if (selectElement != null) {
    selectElement(selectedElement);
    }
    print("Tapped on: ${selectedElement.widget}");
  });

  return SelectedElement(
    type: selectedElement.type,
    widget: wrappedWidget,
    isLayout: selectedElement.isLayout,
  );
}

SelectedElement updateComponent(SelectedElement selectedElement,
    {Widget? newWidget}) {
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
