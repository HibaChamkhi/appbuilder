import 'dart:convert';

import 'package:app_builder/presentation/type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../utils/create_component.dart';

class LeftSideMenu extends StatefulWidget {
  final TextEditingController heightController;
  final TextEditingController widthController;
  final TextEditingController nameController;
  final Color selectedColor;
  final SelectedElement? selectedElement;
  final Map<String, dynamic> params;
  final Function(Map<String, dynamic>) onParamsUpdated;
  final Function(Color) onColorChanged;
  final bool showScreenParameters;

  const LeftSideMenu({
    super.key,
    required this.heightController,
    required this.widthController,
    required this.nameController,
    required this.selectedColor,
    required this.selectedElement,
    required this.params,
    required this.onParamsUpdated,
    required this.onColorChanged,
    required this.showScreenParameters,
  });

  @override
  _LeftSideMenuState createState() => _LeftSideMenuState();
}

class _LeftSideMenuState extends State<LeftSideMenu> {
  Map<String, dynamic> localParams = {};

  @override
  void initState() {
    super.initState();
    localParams = widget.params; // Initialize with passed params
  }

  @override
  Widget build(BuildContext context) {
    print('pramas:: $localParams');
    
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget.selectedElement != null) ...[
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
              localParams['color'] = color;
            });
            widget.onParamsUpdated(localParams); // Update params in parent
          },
        ),
        const Text('Text:'),
        TextField(
          controller: TextEditingController(text: localParams['text']),
          onChanged: (value) {
            setState(() {
              localParams['text'] = value;
            });
            widget.onParamsUpdated(localParams); // Update params in parent
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
              localParams['color'] = color;
            });
            widget.onParamsUpdated(localParams); // Update params in parent
          },
        ),
        const SizedBox(height: 20),
        const Text('Icon Size:'),
        Slider(
          value: localParams['size'] ?? 24.0,
          min: 10.0,
          max: 100.0,
          onChanged: (value) {
            setState(() {
              localParams['size'] = value;
            });
            widget.onParamsUpdated(localParams); // Update params in parent
          },
        ),
      ]);
    }

    return fields;
  }
}
