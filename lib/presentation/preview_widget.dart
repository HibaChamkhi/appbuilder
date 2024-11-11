import 'package:app_builder/presentation/type_model.dart';
import 'package:app_builder/utils/create_component.dart';
import 'package:app_builder/utils/wrap_with_parent.dart';
import 'package:flutter/material.dart';

class PreviewWidget extends StatefulWidget {
  final double selectedHeight;
  final double selectedWidth;
  final Color selectedColor;
  final List<SelectedElement> draggableItems;
  final Function() resetSelection;
  final Function(SelectedElement) addElement;
  final Function(Type) onLayoutSelected; // Callback for layout selection
  final Color elementColor;

  const PreviewWidget({
    Key? key,
    required this.selectedHeight,
    required this.selectedWidth,
    required this.selectedColor,
    required this.draggableItems,
    required this.resetSelection,
    required this.addElement,
    required this.onLayoutSelected,
    required this.elementColor,
  }) : super(key: key);

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  Type? selectedLayout; // Tracks the selected layout type

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // widget.resetSelection();
        },
        child: Center(
          child: Container(
            height: widget.selectedHeight,
            width: widget.selectedWidth,
            color: Colors.white,
            child: Stack(
              children: [
                DragTarget<SelectedElement>(
                  onAccept: (data) {
                    // if (widget.draggableItems.isNotEmpty) {
                    //   var existingComponent = widget.draggableItems.last;
                    //
                    //   if (existingComponent.isLayout == true) {
                    //     setState(() {
                    //       widget.draggableItems[widget.draggableItems.length - 1] = existingComponent;
                    //     });
                    //   } else {
                    //     // If the last item does not have a layout parent, show inline layout selection
                    //     setState(() {
                    //       selectedLayout = null; // Reset layout choice
                    //     });
                    //   }
                    // } else {
                    //   widget.addElement(data);
                    // }
                    widget.addElement(data);

                  },
                  builder: (context, candidateData, rejectedData) {
                    if (widget.draggableItems.isEmpty) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_box_outlined, color: Colors.white, size: 40),
                          Text("Empty Screen", style: TextStyle(color: Colors.white)),
                          Text(
                            "Drag a layout element from the left to get started",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    }

                    // Group elements by layoutParent
                    Map<Type?, List<SelectedElement>> layoutGroups = {};
                    for (var component in widget.draggableItems) {
                      layoutGroups.putIfAbsent(component.layoutParent, () => []);
                      layoutGroups[component.layoutParent]!.add(component);
                    }

                    List<Widget> children = [];

                    // Iterate over layout groups to build UI
                    layoutGroups.forEach((layoutParent, elements) {
                      Widget layout;
                      if (layoutParent == Column) {
                        layout = Column(
                          children: elements.map((e) => buildComponent(e.widget)).toList(),
                        );
                      } else if (layoutParent == Row) {
                        layout = Row(
                          children: elements.map((e) => buildComponent(e.widget)).toList(),
                        );
                      } else if (layoutParent == Stack) {
                        layout = Stack(
                          children: elements.map((e) => buildComponent(e.widget)).toList(),
                        );
                      } else {
                        layout = buildComponent(elements.first.widget);
                      }
                      children.add(layout);
                    });

                    return Stack(
                      children: [
                        Stack(children: children),
                        if (selectedLayout == null)
                          buildInlineLayoutSelection(), // Show inline layout options when no layout is selected
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInlineLayoutSelection() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select Layout", style: TextStyle(fontSize: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedLayout = Row; // Update layout selection
                        widget.onLayoutSelected(Row); // Notify parent widget
                      });
                    },
                    child: const Text('Row'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedLayout = Column; // Update layout selection
                        widget.onLayoutSelected(Column); // Notify parent widget
                      });
                    },
                    child: const Text('Column'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedLayout = Stack; // Update layout selection
                        widget.onLayoutSelected(Stack); // Notify parent widget
                      });
                    },
                    child: const Text('Stack'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
