import 'package:flutter/material.dart';

import '../presentation/component.dart';
import '../presentation/type_model.dart';

SelectedElement wrapWithRow(
    {required SelectedElement firstComponent,
    required SelectedElement secondComponent}) {
  return SelectedElement(
      type: Row,
      widget: Row(
        children: [firstComponent.widget, secondComponent.widget],
      ),
      isLayout: true);
}

SelectedElement wrapWithColumn(
    {required SelectedElement firstComponent,
    required SelectedElement secondComponent}) {
  return SelectedElement(
      type: Column,
      widget: Column(
        children: [firstComponent.widget, secondComponent.widget],
      ),
      isLayout: true);
}

SelectedElement wrapWithStack(
    {required SelectedElement firstComponent,
    required SelectedElement secondComponent}) {
  return SelectedElement(
      type: Stack,
      widget: Stack(
        children: [firstComponent.widget, secondComponent.widget],
      ),
      isLayout: true);
}

SelectedElement wrapWithParent({
  required SelectedElement existingComponent,
  required SelectedElement newComponent,
}) {
  if (existingComponent.widget is Column) {
    return SelectedElement(
      type: Column,
      widget: Column(
        children: [
          ...(existingComponent.widget as Column).children,
          newComponent.widget
        ],
      ),
    );
  } else if (existingComponent.widget is Row) {
    return SelectedElement(
      type: Row,
      widget: Row(
        children: [
          ...(existingComponent.widget as Row).children,
          newComponent.widget
        ],
      ),
    );
  } else if (existingComponent.widget is Stack) {
    return SelectedElement(
      type: Stack,
      widget: Stack(
        children: [
          ...(existingComponent.widget as Stack).children,
          newComponent.widget
        ],
      ),
    );
  }

  // Return the existing component unchanged if it doesn't match the above types
  return existingComponent;
}
