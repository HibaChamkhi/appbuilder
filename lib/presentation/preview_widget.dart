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
              onAccept: (data) {},
              builder: (context, candidateData, rejectedData) {
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
                  },
            ),
          ),
        ),
      ),
    );
  }
}
