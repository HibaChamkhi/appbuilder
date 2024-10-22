import 'package:app_builder/presentation/preview_widget.dart';
import 'package:app_builder/presentation/right_side_widget.dart';
import 'package:app_builder/utils/create_component.dart';
import 'package:flutter/material.dart';

import ' left_side_widget.dart';
import 'component.dart'; // Component class from your existing file


class AppBuilderScreen extends StatefulWidget {
  const AppBuilderScreen({super.key});

  @override
  _AppBuilderScreenState createState() => _AppBuilderScreenState();
}

class _AppBuilderScreenState extends State<AppBuilderScreen> {
  double selectedHeight = 852;
  double selectedWidth = 393;
  Color selectedColor = Colors.black;
  Color elementColor = Colors.white;
  List<String> elements = ["Text", "Icon", "Button"];
  String? draggedElement;
  String? selectedElement;
  bool showScreenParameters = true;

  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final List<Component> _draggableItems = [];

  @override
  void initState() {
    super.initState();
    heightController.text = selectedHeight.toString();
    widthController.text = selectedWidth.toString();

    // Add listeners to update the height and width when the user changes them
    heightController.addListener(_updateSelectedHeight);
    widthController.addListener(_updateSelectedWidth);
  }

  @override
  void dispose() {
    heightController.removeListener(_updateSelectedHeight);
    widthController.removeListener(_updateSelectedWidth);
    heightController.dispose();
    widthController.dispose();
    nameController.dispose();
    super.dispose();
  }

  // Method to update the selected height based on user input
  void _updateSelectedHeight() {
    setState(() {
      selectedHeight = double.tryParse(heightController.text) ?? selectedHeight;
    });
  }

  // Method to update the selected width based on user input
  void _updateSelectedWidth() {
    setState(() {
      selectedWidth = double.tryParse(widthController.text) ?? selectedWidth;
    });
  }

  void updateSelectedElement(String element) {
    setState(() {
      selectedElement = element;
      showScreenParameters = false;
    });
  }

  void resetSelection() {
    setState(() {
      showScreenParameters = true;
    });
  }

  void addElement(String type) {
    setState(() {
      final newComponent = createComponent(type, Colors.green, updateSelectedElement);
      _draggableItems.add(newComponent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LeftSideMenu(
            heightController: heightController,
            widthController: widthController,
            nameController: nameController,
            selectedColor: selectedColor,
            showScreenParameters: showScreenParameters,
            selectedElement: selectedElement,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
              });
            },
            onElementColorChanged: (color) {
              setState(() {
                elementColor = color;
                print(elementColor);
              });
            },
          ),
          PreviewWidget(
            selectedHeight: selectedHeight,
            selectedWidth: selectedWidth,
            selectedColor: selectedColor,
            draggableItems: _draggableItems,
            onTapElement: updateSelectedElement,
            resetSelection: resetSelection,
            addElement: addElement,
            elementColor: elementColor,
          ),
          RightSideMenu(elements: elements),
        ],
      ),
    );
  }
}
