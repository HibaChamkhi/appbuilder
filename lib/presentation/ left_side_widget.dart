import 'dart:convert';

import 'package:app_builder/presentation/type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../utils/create_component.dart';


// LeftSideMenu Code
class LeftSideMenu extends StatefulWidget {
  final TextEditingController heightController;
  final TextEditingController widthController;
  final TextEditingController nameController;
  final Color selectedColor;
  final SelectedElement? selectedElement;
  final Function(Color) onColorChanged;
  final bool showScreenParameters ;
  const LeftSideMenu({
    super.key,
    required this.heightController,
    required this.widthController,
    required this.nameController,
    required this.selectedColor,
    required this.selectedElement,
    required this.onColorChanged,
    required this.showScreenParameters,
  });

  @override
  _LeftSideMenuState createState() => _LeftSideMenuState();
}

class _LeftSideMenuState extends State<LeftSideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:Column(
          children: [
            if ( widget.showScreenParameters == true) ...[
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
            ]else...[
              Text(widget.selectedElement!.type.toString()),
              BlockPicker(
                pickerColor: widget.selectedColor,
                onColorChanged: widget.onColorChanged,
              ),
            ]
          ],
        )

      ),
    );
  }
}