import 'package:app_builder/presentation/bloc/component_bloc.dart';
import 'package:app_builder/presentation/preview_widget.dart';
import 'package:app_builder/presentation/right_side_widget.dart';
import 'package:app_builder/presentation/type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import ' left_side_widget.dart';
import '../utils/create_component.dart';

class AppBuilderScreen extends StatefulWidget {
  const AppBuilderScreen({super.key, required this.state});

  final ComponentState state;

  @override
  _AppBuilderScreenState createState() => _AppBuilderScreenState();
}

class _AppBuilderScreenState extends State<AppBuilderScreen> {
  double selectedHeight = 852;
  double selectedWidth = 393;
  Color selectedColor = Colors.black;
  Color elementColor = Colors.white;
  Map<String, dynamic> params = {};

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

    // Initialize the params (you could add default values here if needed)
    params = {
      'color': selectedColor,
      'text': '', // Add default text if needed
      // Add other params as required
    };
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
      // Reset logic if needed
    });
  }

  void addElement(SelectedElement selectedElement) {
    setState(() {
      BlocProvider.of<ComponentBloc>(context)
          .add(AddDraggableItemEvent(selectedElement));
    });
  }

  // Method to update the selected element's params and trigger the event
  void updateSelectedElement() {
    final widgetFromParams = mapParamsToWidget(params);

    if (widget.state.selectedElement != null) {
      BlocProvider.of<ComponentBloc>(context).add(EditDraggableItemEvent(
        widget.state.selectedElement!.id,
        widgetFromParams,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.9),
      body: Row(
        children: [
          LeftSideMenu(
            heightController: heightController,
            widthController: widthController,
            nameController: nameController,
            selectedColor: selectedColor,
            showScreenParameters: false,
            selectedElement: widget.state.selectedElement,
            params: params, // Pass the params map
            onParamsUpdated: (updatedParams) {
              setState(() {
                params = updatedParams; // Update the params map
              });
              updateSelectedElement(); // Trigger element update
            },
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
                params['color'] = color; // Update the color in params
              });
              updateSelectedElement();
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
          ),
          RightSideMenu(elements: typeToWidgetMap),
        ],
      ),
    );
  }
}
