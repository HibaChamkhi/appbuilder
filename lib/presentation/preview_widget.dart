import 'package:app_builder/utils/create_component.dart';
import 'package:app_builder/utils/wrap_with_parent.dart';
import 'package:flutter/material.dart';
import 'component.dart'; // Component class from your existing file

class PreviewWidget extends StatefulWidget {
  final double selectedHeight;
  final double selectedWidth;
  final Color selectedColor;
  final List<Widget> draggableItems;
  final Function(Map<Type, Widget>) onTapElement;
  final Function() resetSelection;
  final Function(Widget) addElement;
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
            child: DragTarget<Widget>(
              onAccept: (data) {
                print(data);
                if (widget.draggableItems.isNotEmpty) {
                  print("object");
                  var existingComponent = widget.draggableItems.last;

                  // Check if the existing component is a layout
                  // if (existingComponent.isLayout) {
                  //   final newComponent = createComponent(data);
                  //   existingComponent = wrapWithParent(
                  //     existingComponent: existingComponent.child,
                  //     newComponent: newComponent,
                  //   );
                  //
                  //   setState(() {
                  //     widget.draggableItems[widget.draggableItems.length - 1] = existingComponent;
                  //   });
                  // } else {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: const Text('Choose Layout'),
                  //         content: const Text('How would you like to arrange the elements?'),
                  //         actions: [
                  //           TextButton(
                  //             onPressed: () {
                  //               final newComponent = createComponent(data,);
                  //               widget.draggableItems.removeLast();
                  //               widget.draggableItems.add(wrapWithRow(
                  //                 firstComponent: existingComponent,
                  //                 secondComponent: newComponent,
                  //               ));
                  //               Navigator.of(context).pop();
                  //             },
                  //             child: const Text('Row'),
                  //           ),
                  //           TextButton(
                  //             onPressed: () {
                  //               final newComponent = createComponent(data);
                  //               widget.draggableItems.removeLast();
                  //               widget.draggableItems.add(wrapWithColumn(
                  //                 firstComponent: existingComponent,
                  //                 secondComponent: newComponent,
                  //               ));
                  //               Navigator.of(context).pop();
                  //             },
                  //             child: const Text('Column'),
                  //           ),
                  //           TextButton(
                  //             onPressed: () {
                  //               final newComponent = createComponent(data);
                  //               widget.draggableItems.removeLast();
                  //               widget.draggableItems.add(wrapWithStack(
                  //                 firstComponent: existingComponent.child,
                  //                 secondComponent: newComponent,
                  //               ));
                  //               Navigator.of(context).pop();
                  //             },
                  //             child: const Text('Stack'),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }
                } else {
                  widget.addElement(data);
                }
              },
              builder: (context, candidateData, rejectedData) {
                print("widget.draggableItems ${widget.draggableItems}");
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
                    // _hoverStates.putIfAbsent(component, () => false);

                    return Positioned(
                      left: 20.0 * widget.draggableItems.indexOf(component),
                      top: 20.0 * widget.draggableItems.indexOf(component),

                      // child: MouseRegion(
                      //   onEnter: (_) {
                      //     setState(() {
                      //       _hoverStates[component] = true;
                      //     });
                      //   },
                      //   onExit: (_) {
                      //     setState(() {
                      //       _hoverStates[component] = false;
                      //     });
                      //   },
                        child: GestureDetector(
                          onTap: () {
                            // widget.onTapElement(component);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: _hoverStates[component] == true
                                  ? Border.all(color: Colors.blueAccent, width: 2)
                                  : null,
                            ),
                            child: buildComponent(component), // Pass the color and onTapElement here
                          ),
                        ),
                      //        ),
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
