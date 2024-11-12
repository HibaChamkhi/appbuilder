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
  late TextEditingController colorCodeController;
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.selectedColor;
    colorCodeController = TextEditingController(
      text: '#${currentColor.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
    );
  }

  void updateColorFromCode(String code) {
    try {
      final color = Color(int.parse(code.replaceFirst('#', '0xff')));
      setState(() {
        currentColor = color;
      });
      widget.onColorChanged(color);
    } catch (e) {
      // Handle invalid color code
    }
  }

  @override
  void dispose() {
    colorCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: const Color(0xffe5e1e7),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget.showScreenParameters) ...[
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
                pickerColor: currentColor,
                onColorChanged: (color) {
                  setState(() {
                    currentColor = color;
                    colorCodeController.text =
                    '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                  });
                  widget.onColorChanged(color);
                },
              ),
            ] else ...[
              const Text("Pick element color:"),
              BlockPicker(
                pickerColor: currentColor,
                onColorChanged: (color) {
                  setState(() {
                    currentColor = color;
                    colorCodeController.text =
                    '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                  });
                  widget.onElementColorChanged(color);
                },
              ),
              const SizedBox(height: 20),
              if (widget.selectedElement != null)
                Text(
                  "Selected: ${widget.selectedElement}",
                  style: const TextStyle(color: Colors.black),
                ),
            ],
            const SizedBox(height: 20),
            TextField(
              controller: colorCodeController,
              decoration: const InputDecoration(
                labelText: 'Enter Color Code',
                border: OutlineInputBorder(),
              ),
              onSubmitted: updateColorFromCode,
            ),
          ],
        ),
      ),
    );
  }
}
