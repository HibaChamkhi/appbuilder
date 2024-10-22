import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class LeftSideMenu extends StatefulWidget {
  final TextEditingController heightController;
  final TextEditingController widthController;
  final TextEditingController nameController;
  final Color selectedColor;
  final bool showScreenParameters;
  final String? selectedElement;
  final Function(Color) onColorChanged;
  final Function(Color) onElementColorChanged;

  const LeftSideMenu({
    super.key,
    required this.heightController,
    required this.widthController,
    required this.nameController,
    required this.selectedColor,
    required this.showScreenParameters,
    required this.selectedElement,
    required this.onColorChanged,
    required this.onElementColorChanged,
  });

  @override
  _LeftSideMenuState createState() => _LeftSideMenuState();
}

class _LeftSideMenuState extends State<LeftSideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Removes the border radius
      ),
      backgroundColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget.showScreenParameters) ...[
              TextField(
                controller: widget.nameController,
                decoration: const InputDecoration(
                  labelText: 'Interface Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
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
            ] else ...[
              const Text("Pick element color:"),
              BlockPicker(
                pickerColor: widget.selectedColor,
                onColorChanged: widget.onElementColorChanged,
              ),
              const SizedBox(height: 20),
              if (widget.selectedElement != null)
                Text(
                  "Selected: ${widget.selectedElement}",
                  style: const TextStyle(color: Colors.black),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
