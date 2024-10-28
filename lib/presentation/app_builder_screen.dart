import 'package:app_builder/presentation/bloc/component_bloc.dart';
import 'package:app_builder/presentation/preview_widget.dart';
import 'package:app_builder/presentation/right_side_widget.dart';
import 'package:app_builder/presentation/type_model.dart';
import 'package:app_builder/utils/create_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import ' left_side_widget.dart';

class AppBuilderScreen extends StatefulWidget {
  const AppBuilderScreen({super.key, required this.state});
  final ComponentState state ;
  @override
  _AppBuilderScreenState createState() => _AppBuilderScreenState();
}

class _AppBuilderScreenState extends State<AppBuilderScreen> {
  double selectedHeight = 852;
  double selectedWidth = 393;
  Color selectedColor = Colors.black;
  Color elementColor = Colors.white;
  bool showScreenParameters = true;

  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

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

  void resetSelection() {
    setState(() {
      showScreenParameters = true;
    });
  }

  void addElement(SelectedElement selectedElement) {
    setState(() {
      BlocProvider.of<ComponentBloc>(context).add( AddDraggableItemEvent(selectedElement));
    });
  }

  void updateSelectedElement(SelectedElement updatedElement) {
    setState(() {
      final index = widget.state.draggableItems
          ?.indexWhere((element) => element.id == updatedElement.id);
      if (index != -1) {
        widget.state.draggableItems?[index!] = updatedElement;
      }
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
            selectedElement: widget.state.selectedElement,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
          PreviewWidget(
            selectedHeight: selectedHeight,
            selectedWidth: selectedWidth,
            selectedColor: selectedColor,
            draggableItems: widget.state.draggableItems ?? [],
            resetSelection: resetSelection,
            addElement: addElement,
            elementColor: elementColor,
            tapElement: (SelectedElement element) {
              setState(() {
                // selectedElement = element;
              });
            },
          ),
          RightSideMenu(elements: typeToWidgetMap),
        ],
      ),
    );
  }
}
