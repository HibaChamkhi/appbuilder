import 'package:app_builder/utils/create_component.dart';
import 'package:app_builder/utils/wrap_with_parent.dart';
import 'package:flutter/material.dart';
import 'component.dart'; // Component class from your existing file

class PreviewWidget extends StatelessWidget {
  final double selectedHeight;
  final double selectedWidth;
  final Color selectedColor;
  final List<Component> draggableItems;
  final Function(String) onTapElement;
  final Function() resetSelection;
  final Function(String) addElement;
  final Color elementColor;

  const PreviewWidget({
    Key? key,
    required this.selectedHeight,
    required this.selectedWidth,
    required this.selectedColor,
    required this.draggableItems,
    required this.onTapElement,
    required this.resetSelection,
    required this.addElement,
    required this.elementColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("elementColor $elementColor");
    return Expanded(
      child: GestureDetector(
        onTap: () {
          resetSelection();
        },
        child: Center(
          child: Container(
            height: selectedHeight,
            width: selectedWidth,
            color: selectedColor,
            child: DragTarget<String>(
              onAccept: (data) {
                if (draggableItems.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Choose Layout'),
                        content: const Text('How would you like to arrange the elements?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              final existingComponent = draggableItems.last;
                              final newComponent = createComponent(data, elementColor, onTapElement);
                              draggableItems.removeLast();
                              draggableItems.add(wrapWithRow(
                                firstComponent: existingComponent.child,
                                secondComponent: newComponent,
                              ));
                              Navigator.of(context).pop();
                            },
                            child: const Text('Row'),
                          ),
                          TextButton(
                            onPressed: () {
                              final existingComponent = draggableItems.last;
                              final newComponent = createComponent(data, elementColor, onTapElement);
                              draggableItems.removeLast();
                              draggableItems.add(wrapWithColumn(
                                firstComponent: existingComponent.child,
                                secondComponent: newComponent,
                              ));
                              Navigator.of(context).pop();
                            },
                            child: const Text('Column'),
                          ),
                          TextButton(
                            onPressed: () {
                              final existingComponent = draggableItems.last;
                              final newComponent = createComponent(data, elementColor, onTapElement);
                              draggableItems.removeLast();
                              draggableItems.add(wrapWithStack(
                                firstComponent: existingComponent.child,
                                secondComponent: newComponent,
                              ));
                              Navigator.of(context).pop();
                            },
                            child: const Text('Stack'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  addElement(data);
                }
              },
              builder: (context, candidateData, rejectedData) {
                if (draggableItems.isEmpty) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_box_outlined, color: Colors.white, size: 40),
                      Text("Empty Screen", style: TextStyle(color: Colors.white)),
                      Text(
                        "Drag a layout element from the left in order to get started",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                }
                return Stack(
                  children: draggableItems.map((component) {
                    return Positioned(
                      left: 20.0,
                      top: 20.0,
                      child: GestureDetector(
                        onTap: () {
                          // Pass the type of the element (Text, Icon, etc.)
                          onTapElement(component.child.toString()); // Assuming it represents the type
                        },
                        child: buildComponent(component, elementColor, onTapElement), // Pass the color and onTapElement here
                      ),
                    );
                  }).toList(),
                );

              },
            ),
          ),
        ),
      ),
    );
  }

}
