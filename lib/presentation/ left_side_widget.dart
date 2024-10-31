import 'dart:convert';
import 'package:app_builder/presentation/type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class LeftSideMenu extends StatefulWidget {
  final TextEditingController heightController;
  final TextEditingController widthController;
  final TextEditingController nameController;
  final Color selectedColor;
  final SelectedElement? selectedElement;
  final Function(Color) onColorChanged;
  final bool showScreenParameters;
  final Function(Widget) onWidgetUpdated; // New callback

  const LeftSideMenu({
    super.key,
    required this.heightController,
    required this.widthController,
    required this.nameController,
    required this.selectedColor,
    required this.selectedElement,
    required this.onColorChanged,
    required this.showScreenParameters,
    required this.onWidgetUpdated, // Initialize in constructor
  });

  @override
  _LeftSideMenuState createState() => _LeftSideMenuState();
}



class _LeftSideMenuState extends State<LeftSideMenu> {
  Map<String, dynamic> extractedParams = {};

  @override
  void initState() {
    super.initState();
    if (widget.selectedElement != null) {
      extractedParams = widget.selectedElement!.extractParams();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget.showScreenParameters) ...[
              TextField(
                controller: widget.heightController,
                decoration: const InputDecoration(
                  labelText: 'Height',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.widthController,
                decoration: const InputDecoration(
                  labelText: 'Width',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Pick screen background color:"),
              BlockPicker(
                pickerColor: widget.selectedColor,
                onColorChanged: widget.onColorChanged,
              ),
            ]
           else if (widget.selectedElement != null) ...[
              // Dynamically generated fields for the selected element
              ..._buildDynamicFields(widget.selectedElement!),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDynamicFields(SelectedElement selectedElement) {
    List<Widget> fields = [];

    if (selectedElement.type == Text) {
      fields.addAll([
        const SizedBox(height: 20),
        const Text('Text Color:'),
        BlockPicker(
          pickerColor: widget.selectedColor,
          onColorChanged: (color) {
            widget.onColorChanged(color);
            setState(() {
              extractedParams['color'] = color;
            });
            // Generate updated widget with new color
            widget.onWidgetUpdated(_createUpdatedWidget());
          },
        ),
        const Text('Text:'),
        TextField(
          controller: widget.nameController, // Use the existing controller
          onChanged: (value) {
            setState(() {
              extractedParams['text'] = value;
            });
            // Generate updated widget with new text
            widget.onWidgetUpdated(_createUpdatedWidget());
          },
          decoration: const InputDecoration(
            labelText: 'Enter text',
            border: OutlineInputBorder(),
          ),
        ),

      ]);
    } else if (selectedElement.type == Icon) {
      fields.addAll([
        const SizedBox(height: 20),
        const Text('Icon Color:'),
        BlockPicker(
          pickerColor: widget.selectedColor,
          onColorChanged: (color) {
            widget.onColorChanged(color);
            setState(() {
              extractedParams['color'] = color;
            });
            // Generate updated widget with new color
            widget.onWidgetUpdated(_createUpdatedWidget());
          },
        ),
        const SizedBox(height: 20),
        const Text('Icon Size:'),
        Slider(
          value: extractedParams['size'] ?? 24.0,
          min: 10.0,
          max: 100.0,
          onChanged: (value) {
            setState(() {
              extractedParams['size'] = value;
            });
            // Generate updated widget with new size
            widget.onWidgetUpdated(_createUpdatedWidget());
          },
        ),
      ]);
    }

    return fields;
  }


  Widget _createUpdatedWidget() {
    if (widget.selectedElement!.type == Text) {
      return Text(
        extractedParams['text'] ?? '', // Ensure there's always a string
        style: TextStyle(color: extractedParams['color']),
      );
    } else if (widget.selectedElement!.type == Icon) {
      return Icon(
        Icons.star, // Replace with your icon type
        color: extractedParams['color'],
        size: extractedParams['size'],
      );
    }
    return Container(); // Default case
  }


}