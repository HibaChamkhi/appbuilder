import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightSideMenu extends StatefulWidget {
  final Map<Type, Widget> elements;

  const RightSideMenu({
    super.key,
    required this.elements,
  });

  @override
  _RightSideMenuState createState() => _RightSideMenuState();
}

class _RightSideMenuState extends State<RightSideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes the border radius
      ),
      backgroundColor: Colors.grey,
      child: Column(
        children: [
          const Text("Add UI Elements"),
          const Divider(color: Colors.white),
          Expanded(
            child: ListView.builder(
              itemCount: widget.elements.length,
              itemBuilder: (context, index) {
                // Get the Type key directly
                Type elementType = widget.elements.keys.elementAt(index);
                Widget elementWidget = widget.elements[elementType]!;

                return Draggable<Type>(
                  data: elementType, // Use the Type as the drag data
                  feedback: Material(
                    color: Colors.transparent,
                    child: Text(elementType.toString()), // Display widget during drag
                  ),
                  onDragStarted: () {
                    // Print the widget code when dragging starts
                    print("Dragged widget: ${elementWidget.toString()}");
                  },
                  child: ListTile(
                    title: Text(elementType.toString()), // Display Type name
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

