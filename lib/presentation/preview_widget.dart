import 'package:app_builder/utils/create_component.dart';
import 'package:app_builder/utils/wrap_with_parent.dart';
import 'package:flutter/material.dart';
import 'component.dart'; // Component class from your existing file

class PreviewWidget extends StatefulWidget {
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
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  // Store the hover state for each component using a map.
  final Map<Component, bool> _hoverStates = {};

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.resetSelection();
        },
        child: Center(
          child: Container(
            height: widget.selectedHeight,
            width: widget.selectedWidth,
            color: widget.selectedColor,
            child: DragTarget<String>(
              onAccept: (data) {
                if (widget.draggableItems.isNotEmpty) {
                  var existingComponent = widget.draggableItems.last;

                  // Check if the existing component is a layout
                  if (existingComponent.isLayout) {
                    final newComponent = createComponent(data, widget.elementColor, widget.onTapElement);
                    existingComponent = wrapWithParent(
                      existingComponent: existingComponent.child,
                      newComponent: newComponent,
                    );

                    setState(() {
                      widget.draggableItems[widget.draggableItems.length - 1] = existingComponent;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Choose Layout'),
                          content: const Text('How would you like to arrange the elements?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                final newComponent = createComponent(data, widget.elementColor, widget.onTapElement);
                                widget.draggableItems.removeLast();
                                widget.draggableItems.add(wrapWithRow(
                                  firstComponent: existingComponent.child,
                                  secondComponent: newComponent,
                                ));
                                Navigator.of(context).pop();
                              },
                              child: const Text('Row'),
                            ),
                            TextButton(
                              onPressed: () {
                                final newComponent = createComponent(data, widget.elementColor, widget.onTapElement);
                                widget.draggableItems.removeLast();
                                widget.draggableItems.add(wrapWithColumn(
                                  firstComponent: existingComponent.child,
                                  secondComponent: newComponent,
                                ));
                                Navigator.of(context).pop();
                              },
                              child: const Text('Column'),
                            ),
                            TextButton(
                              onPressed: () {
                                final newComponent = createComponent(data, widget.elementColor, widget.onTapElement);
                                widget.draggableItems.removeLast();
                                widget.draggableItems.add(wrapWithStack(
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
                  }
                } else {
                  widget.addElement(data);
                }
              },
              builder: (context, candidateData, rejectedData) {
                if (widget.draggableItems.isEmpty) {
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
                  children: widget.draggableItems.map((component) {
                    // Initialize the hover state if it doesn't exist.
                    _hoverStates.putIfAbsent(component, () => false);

                    return Positioned(
                      left: 20.0 * widget.draggableItems.indexOf(component),
                      top: 20.0 * widget.draggableItems.indexOf(component),

                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoverStates[component] = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoverStates[component] = false;
                          });
                        },
                        child: GestureDetector(
                          onTap: () {
                            widget.onTapElement(component.child.toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: _hoverStates[component] == true
                                  ? Border.all(color: Colors.blueAccent, width: 2)
                                  : null,
                            ),
                            child: buildComponent(component, widget.elementColor, widget.onTapElement), // Pass the color and onTapElement here
                          ),
                        ),
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

  // void _addElementToLayout(String data, BuildContext context, String layoutType) {
  //   final existingComponent = draggableItems.isNotEmpty ? draggableItems.last : null;
  //   final newComponent = createComponent(data, elementColor, onTapElement);
  //   if (existingComponent != null) {
  //     draggableItems.removeLast();
  //
  //     if (layoutType == 'Row') {
  //       draggableItems.add(wrapWithRow(
  //         firstComponent: existingComponent.child,
  //         secondComponent: newComponent,
  //       ));
  //     } else if (layoutType == 'Column') {
  //       draggableItems.add(wrapWithColumn(
  //         firstComponent: existingComponent.child,
  //         secondComponent: newComponent,
  //       ));
  //     } else if (layoutType == 'Stack') {
  //       draggableItems.add(wrapWithStack(
  //         firstComponent: existingComponent.child,
  //         secondComponent: newComponent,
  //       ));
  //     }
  //     Navigator.of(context).pop();
  //   } else {
  //     addElement(data);
  //   }
  // }
}
