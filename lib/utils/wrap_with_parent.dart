// Helper functions to wrap components into layouts
import 'package:flutter/cupertino.dart';

import '../presentation/component.dart';

Component wrapWithRow({
  required Component firstComponent,
  required Component secondComponent,
}) {
  return Component(
    isLayout: true,
    type: 'layout',
    styleModel: firstComponent.styleModel,
    child: Row(
      children: [firstComponent.child!, secondComponent.child!],
    ),
  )
    ..childCode = "Row(children: [${firstComponent.childCode}, ${secondComponent.childCode}])";
}

Component wrapWithColumn({
  required Component firstComponent,
  required Component secondComponent,
}) {
  return Component(
    isLayout: true,
    type: 'layout',
    styleModel: firstComponent.styleModel,
    child: Column(
      children: [firstComponent.child!, secondComponent.child!],
    ),
  )
    ..childCode = "Column(children: [${firstComponent.childCode}, ${secondComponent.childCode}])";
}

Component wrapWithStack({
  required Component firstComponent,
  required Component secondComponent,
}) {
  return Component(
    isLayout: true,
    type: 'layout',
    styleModel: firstComponent.styleModel,
    child: Stack(
      children: [firstComponent.child!, secondComponent.child!],
    ),
  )
    ..childCode = "Stack(children: [${firstComponent.childCode}, ${secondComponent.childCode}])";
}

// This function adds a new component inside an existing layout component (Row, Column, or Stack).
Component wrapWithParent({
  required Component existingComponent,
  required Component newComponent,
}) {
  if (existingComponent.child is Column) {
    return Component(
      isLayout: true,
      type: 'layout',
      styleModel: existingComponent.styleModel,
      child: Column(
        children: [...(existingComponent.child as Column).children, newComponent.child!],
      ),
    )
      ..childCode = "Column(children: [...${existingComponent.childCode}.children, ${newComponent.childCode}])";
  } else if (existingComponent.child is Row) {
    return Component(
      isLayout: true,
      type: 'layout',
      styleModel: existingComponent.styleModel,
      child: Row(
        children: [...(existingComponent.child as Row).children, newComponent.child!],
      ),
    )
      ..childCode = "Row(children: [...${existingComponent.childCode}.children, ${newComponent.childCode}])";
  } else if (existingComponent.child is Stack) {
    return Component(
      isLayout: true,
      type: 'layout',
      styleModel: existingComponent.styleModel,
      child: Stack(
        children: [...(existingComponent.child as Stack).children, newComponent.child!],
      ),
    )
      ..childCode = "Stack(children: [...${existingComponent.childCode}.children, ${newComponent.childCode}])";
  }
  return existingComponent;
}