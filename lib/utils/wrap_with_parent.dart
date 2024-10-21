import 'package:flutter/material.dart';

import '../presentation/component.dart';

// Wraps two components in a Row layout.
Component wrapWithRow({required Widget firstComponent, required Component secondComponent}) {
  return Component(
    child: Row(
      children: [firstComponent, secondComponent.child],
    ),
  );
}

// Wraps two components in a Column layout.
Component wrapWithColumn({required Widget firstComponent, required Component secondComponent}) {
  return Component(
    child: Column(
      children: [firstComponent, secondComponent.child],
    ),
  );
}

// Wraps two components in a Stack layout.
Component wrapWithStack({required Widget firstComponent, required Component secondComponent}) {
  return Component(
    child: Stack(
      children: [firstComponent, secondComponent.child],
    ),
  );
}
