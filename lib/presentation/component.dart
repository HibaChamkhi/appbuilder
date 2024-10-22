import 'package:flutter/cupertino.dart';

class Component extends StatefulWidget {
  final bool isLayout;

  // Initially pass the child widget through the constructor.
  final Widget child;

  Component({required this.child, this.isLayout = false});

  @override
  ComponentState createState() => ComponentState();
}

class ComponentState extends State<Component> {
  late Widget child;

  @override
  void initState() {
    super.initState();
    // Initialize the child with the initial widget passed.
    child = widget.child;
  }

  // Method to update the child widget
  void updateChild(Widget newChild) {
    setState(() {
      child = newChild;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLayout
        ? Container(
      // Layout components such as Column, Row, or Stack can be placed here.
      child: child,
    )
        : child;
  }
}
