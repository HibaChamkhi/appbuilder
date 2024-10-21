import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'component.dart'; // Add this dependency in your pubspec.yaml

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double selectedHeight = 852;
  double selectedWidth = 393;
  Color selectedColor = Colors.black; // Default color
  Color elementColor = Colors.white; // Default element color
  List<String> elements = ["Text", "Icon", "Button"];
  String? draggedElement; // Keep track of the dragged element
  String? selectedElement; // Keep track of the selected element
  bool showScreenParameters = true; // Flag to show/hide screen parameters

  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final List<Component> _draggableItems = [];

  @override
  void initState() {
    super.initState();
    heightController.text = selectedHeight.toString();
    widthController.text = selectedWidth.toString();
  }

  @override
  void dispose() {
    heightController.dispose();
    widthController.dispose();
    nameController.dispose(); // Dispose the name controller
    super.dispose();
  }

  void updateSelectedElement(String element) {
    setState(() {
      print("updateSelectedElement");
      selectedElement = element;
      elementColor = Colors.white;
      showScreenParameters = false;
    });
  }

  void resetSelection() {
    setState(() {
      print("resetSelection");
      // Do not reset selectedElement; just hide parameters
      showScreenParameters =
          true; // Show screen parameters when no element is selected
    });
  }

  void addElement(String type) {
    setState(() {
      // Create a new component based on the dragged element type
      Component newComponent;
      if (type == "Text") {
        newComponent = Component(
            child: GestureDetector(
          onTap: () => updateSelectedElement("Text"),
          // Update selected element on tap
          child: Text(
            'This is some text!',
            style: TextStyle(
                color: elementColor, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ));
      } else if (type == "Button") {
        newComponent = Component(
            child: GestureDetector(
          onTap: () {
            // setState(() {
            //   selectedElement=;
            // });
            updateSelectedElement("Button");
          },
          // Update selected element on tap
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Button', style: TextStyle(color: Colors.black)),
          ),
        ));
      } else {
        newComponent = Component(
          child: GestureDetector(
            onTap: () => updateSelectedElement("Icon"),
            // Update selected element on tap
            child: const Icon(
              Icons.star,
              size: 40,
              color: Colors.white,
            ),
          ),
        );
      }

      // Add the new component to the list
      _draggableItems.add(newComponent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side menu with input fields and color picker
          Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Interface name input

                  // Show height input field if screen parameters are visible
                  if (showScreenParameters) ...[
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Interface Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    // Height input field
                    TextField(
                      controller: heightController,
                      decoration: const InputDecoration(
                        labelText: 'Height',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          selectedHeight =
                              double.tryParse(value) ?? selectedHeight;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Width input field
                    TextField(
                      controller: widthController,
                      decoration: const InputDecoration(
                        labelText: 'Width',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          selectedWidth =
                              double.tryParse(value) ?? selectedWidth;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Color picker for the screen background
                    Row(
                      children: [
                        const Text('Background Color:'),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: selectedColor),
                          child: const Text('Select Color'),
                          onPressed: () {
                            // Show color picker
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Pick a Color'),
                                  content: SingleChildScrollView(
                                    child: BlockPicker(
                                      pickerColor: selectedColor,
                                      onColorChanged: (Color color) {
                                        setState(() {
                                          selectedColor = color;
                                        });
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Select'),
                                      onPressed: () {
                                        setState(() {
                                          // Update selected color
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],

                  // Properties for selected element
                  const SizedBox(height: 20),
                  if (!showScreenParameters && selectedElement != null) ...[
                    const Text('Element Properties:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    // Color picker for selected element
                    Row(
                      children: [
                        const Text('Element Color:'),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: elementColor),
                          child: const Text('Select Color'),
                          onPressed: () {
                            // Show color picker
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Pick a Color'),
                                  content: SingleChildScrollView(
                                    child: BlockPicker(
                                      pickerColor: elementColor,
                                      onColorChanged: (Color color) {
                                        setState(() {
                                          elementColor = color;
                                        });
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Select'),
                                      onPressed: () {
                                        setState(() {
                                          // Update selected element color
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Main interface
          // Main interface Expanded widget
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (selectedElement != null) {
                  resetSelection(); // Show parameters but keep the selected element
                }
              },
              child: Center(
                child: Container(
                  height: selectedHeight,
                  width: selectedWidth,
                  color: selectedColor,
                  child: DragTarget<String>(
                    onAccept: (data) {
                      if (_draggableItems.isNotEmpty) {
                        // Show dialog to ask for layout preference
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Choose Layout'),
                              content: const Text(
                                  'How would you like to arrange the elements?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Wrap in Row
                                    setState(() {
                                      final existingComponent =
                                          _draggableItems.last;
                                      final newComponent =
                                          createComponent(data);
                                      _draggableItems
                                          .removeLast(); // Remove the last component
                                      _draggableItems.add(wrapWithRow(
                                        firstComponent: existingComponent.child,
                                        secondComponent: newComponent,
                                      ));
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Row'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Wrap in Column
                                    setState(() {
                                      final existingComponent =
                                          _draggableItems.last;
                                      final newComponent =
                                          createComponent(data);
                                      _draggableItems
                                          .removeLast(); // Remove the last component
                                      _draggableItems.add(wrapWithColumn(
                                        firstComponent: existingComponent.child,
                                        secondComponent: newComponent,
                                      ));
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Column'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Wrap in Stack
                                    setState(() {
                                      final existingComponent =
                                          _draggableItems.last;
                                      final newComponent =
                                          createComponent(data);
                                      _draggableItems
                                          .removeLast(); // Remove the last component
                                      _draggableItems.add(wrapWithStack(
                                        firstComponent: existingComponent.child,
                                        secondComponent: newComponent,
                                      ));
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Stack'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // If no existing components, just add the new one
                        addElement(data);
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      if (_draggableItems.isEmpty) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_box_outlined,
                                color: Colors.white, size: 40),
                            Text("Empty Screen",
                                style: TextStyle(color: Colors.white)),
                            Text(
                              "Drag a layout element from the left in order to get started",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        );
                      }
                      return Stack(
                        children: _draggableItems.map((component) {
                          return Positioned(
                            left: 20.0, // Adjust for dynamic placement
                            top: 20.0, // Adjust for dynamic placement
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Handle tap to select element
                                });
                              },
                              child: buildComponent(component),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Right side menu with grid of boxes
          Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio: 1, // Aspect ratio of each box
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: elements.length,
                itemBuilder: (context, index) {
                  return Draggable<String>(
                    data: elements[index],
                    feedback: Material(
                      color: Colors.transparent,
                      child: Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text(
                            elements[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      color: Colors.blue.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          elements[index],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          elements[index],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Component createComponent(String type) {
    Color color = elementColor; // Use the current element color
    Widget child;

    if (type == "Text") {
      child = Text(
        'This is some text!',
        style:
            TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold),
      );
    } else if (type == "Button") {
      child = ElevatedButton(
        onPressed: () {},
        child: const Text('Button', style: TextStyle(color: Colors.black)),
      );
    } else {
      // "Icon"
      child = const Icon(
        Icons.star,
        size: 40,
        color: Colors.white,
      );
    }

    return Component(
        child: GestureDetector(
      onTap: () => updateSelectedElement(type),
      child: child,
    ));
  }

  Component wrapWithRow(
      {required Widget firstComponent, required Component secondComponent}) {
    return Component(
      child: Row(
        children: [firstComponent, secondComponent.child],
      ),
    );
  }

  Component wrapWithColumn(
      {required Widget firstComponent, required Component secondComponent}) {
    return Component(
        child: Column(
      children: [firstComponent, secondComponent.child],
    ));
  }

  Component wrapWithStack(
      {required Widget firstComponent, required Component secondComponent}) {
    return Component(
      child: Stack(
        children: [firstComponent, secondComponent.child],
      ),
    );
  }

  // Helper method to build the UI for each component
  Widget buildComponent(Component component) {
    return component.child;
  }
}
