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




