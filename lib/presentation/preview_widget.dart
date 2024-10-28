import 'package:app_builder/presentation/style_model.dart';
import 'package:flutter/material.dart';
import 'component.dart'; // Import the Component class
import 'package:app_builder/utils/create_component.dart';

class PreviewWidget extends StatefulWidget {
  final double selectedHeight;
  final double selectedWidth;
  final Color selectedColor;
  final List<Component> draggableItems;
  final Function(String) onTapElement;
  final Function() resetSelection;
  final Function(String) addElement;

  const PreviewWidget({
    Key? key,
    required this.selectedHeight,
    required this.selectedWidth,
    required this.selectedColor,
    required this.draggableItems,
    required this.onTapElement,
    required this.resetSelection,
    required this.addElement,
  }) : super(key: key);

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  Component? _selectedComponent;
  LayoutComponent? _highlightedLayout; // The layout currently being hovered over

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.resetSelection,
        child: Center(
          child: Container(
            height: widget.selectedHeight,
            width: widget.selectedWidth,
            color: widget.selectedColor,
            child: DragTarget<String>(
              onAccept: (data) {
                setState(() {
                  // Check if there is a highlighted layout
                  if (_highlightedLayout != null ) {
                    // Add the new component to the highlighted layout's children
                    final newComponent = createComponent(data, widget.onTapElement);
                    _highlightedLayout!.children.add(newComponent);
                    _highlightedLayout = null; // Reset highlighted layout
                  } else if ( widget.draggableItems.isNotEmpty) {
                    // No layout was highlighted, wrap existing draggable items with a new layout
                    final newComponent = createComponent(data, widget.onTapElement);
                    final existingComponent = widget.draggableItems.last;
                    widget.draggableItems.removeLast();

                    // Add a new layout that wraps the existing and the new component
                    widget.draggableItems.add(LayoutComponent(
                      children: [existingComponent, newComponent],
                      layoutDirection: Axis.vertical,
                      styleModel: StyleModel(),
                    ));
                  } else {
                    widget.addElement(data);
                  }
                });
              },
              builder: (context, candidateData, rejectedData) {
                if (widget.draggableItems.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_box_outlined, color: Colors.white, size: 40),
                        Text("Empty Screen", style: TextStyle(color: Colors.white)),
                        Text(
                          "Drag a layout element from the right in order to get started",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }

                return _buildComponentTree(widget.draggableItems);
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Recursively build the UI tree from a list of components
  Widget _buildComponentTree(List<Component> components) {
    return Stack(
      children: components.map((component) {
        if (component is LayoutComponent) {
          // Handle LayoutComponent by recursively building its children
          return _buildLayoutComponent(component);
        } else {
          // Handle normal Component
          return _buildComponent(component);
        }
      }).toList(),
    );
  }

  /// Builds the UI for a LayoutComponent and recursively builds its children.
  Widget _buildLayoutComponent(LayoutComponent layoutComponent) {
    List<Widget> childrenWidgets = layoutComponent.children.map((child) {
      // Recursively build children if they are layout components
      if (child is LayoutComponent) {
        return _buildLayoutComponent(child);
      } else {
        return _buildComponent(child);
      }
    }).toList();

    return DragTarget<String>(
      onWillAccept: (data) {
        setState(() {
          _highlightedLayout = layoutComponent; // Highlight this layout
        });
        return true;
      },
      onLeave: (data) {
        setState(() {
          _highlightedLayout = null; // Unhighlight when the drag leaves
        });
      },
      onAccept: (data) {
        final newComponent = createComponent(data, widget.onTapElement);
        setState(() {
          layoutComponent.children.add(newComponent); // Add new component to the layout
          _highlightedLayout = null; // Clear the highlight
        });
      },
      builder: (context, candidateData, rejectedData) {
        // Display the correct layout widget (Column, Row, or Stack)
        Widget layoutWidget;
        if (layoutComponent.isStacked) {
          layoutWidget = Stack(
            children: childrenWidgets,
          );
        } else if (layoutComponent.layoutDirection == Axis.vertical) {
          layoutWidget = Column(
            children: childrenWidgets,
          );
        } else {
          layoutWidget = Row(
            children: childrenWidgets,
          );
        }

        return Container(
          decoration: BoxDecoration(
            border: _highlightedLayout == layoutComponent
                ? Border.all(color: Colors.blueAccent, width: 2) // Show border when highlighted
                : null,
          ),
          child: layoutWidget,
        );
      },
    );
  }

  /// Builds the UI for a single Component.
  Widget _buildComponent(Component component) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedComponent?.deselect(); // Deselect the previously selected component
          _selectedComponent = component; // Set the selected component
          component.select(); // Select the current component
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: component.isSelected
              ? Border.all(color: Colors.blueAccent, width: 2) // Highlight selected component
              : null,
        ),
        child: component.child, // Render the actual widget of the component
      ),
    );
  }
}
