import 'package:flutter/material.dart';

import '../presentation/component.dart';

// Wraps two components in a Row layout.
Component wrapWithRow({required Widget firstComponent, required Component secondComponent}) {
  return Component(
    isLayout: true,
    child: Row(
      children: [firstComponent, secondComponent.child],
    ),
  );
}

// Wraps two components in a Column layout.
Component wrapWithColumn({required Widget firstComponent, required Component secondComponent}) {
  return Component(
    isLayout: true,
    child: Column(
      children: [firstComponent, secondComponent.child],
    ),
  );
}

// Wraps two components in a Stack layout.
Component wrapWithStack({required Widget firstComponent, required Component secondComponent}) {
  return Component(
    isLayout: true,
    child: Stack(
      children: [firstComponent, secondComponent.child],
    ),
  );
}

Component wrapWithParent({
  required Widget existingComponent,
  required Component newComponent,
}) {
  if (existingComponent is Column) {
    return Component(
      isLayout: true,
      child: Column(
        children: [...existingComponent.children, newComponent.child],
      ),
    );
  } else if (existingComponent is Row) {
    return Component(
      isLayout: true,
      child: Row(
        children: [...existingComponent.children, newComponent.child],
      ),
    );
  } else if (existingComponent is Stack) {
    return Component(
      isLayout: true,
      child: Stack(
        children: [...existingComponent.children, newComponent.child],
      ),
    );
  }
  return
    Component(
      child:existingComponent
    )
    ;
}

