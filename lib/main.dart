import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Add this dependency in your pubspec.yaml

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
      showScreenParameters = true; // Show screen parameters when no element is selected
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
                          selectedHeight = double.tryParse(value) ?? selectedHeight;
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
                          selectedWidth = double.tryParse(value) ?? selectedWidth;
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
                          style: ElevatedButton.styleFrom(foregroundColor: selectedColor),
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
                    const Text('Element Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    // Color picker for selected element
                    Row(
                      children: [
                        const Text('Element Color:'),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(foregroundColor: elementColor),
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
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (selectedElement != null) {
                  resetSelection(); // Show parameters but keep the selected element
                }
              }, // Reset the selected element when clicking on the main interface
              child: Center(
                child: Container(
                  height: selectedHeight,
                  width: selectedWidth,
                  color: selectedColor, // Use the selected color
                  child: DragTarget<String>(
                    onAccept: (data) {
                      updateSelectedElement(data); // Update the dragged element
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (selectedElement == null) ...[
                            const Icon(Icons.add_box_outlined, color: Colors.white, size: 40),
                            const Text("Empty Screen", style: TextStyle(color: Colors.white)),
                            const Text("Drag a layout element from the left in order to get started", style: TextStyle(color: Colors.white)),
                          ] else ...[
                            // Display the dragged element based on its type
                            if (selectedElement == "Text")
                              GestureDetector(
                                onTap: () => updateSelectedElement("Text"), // Update selected element on tap
                                child: Text(
                                  'This is some text!',
                                  style: TextStyle(color: elementColor, fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              )
                            else if (selectedElement == "Button")
                              GestureDetector(
                                onTap: () => updateSelectedElement("Button"), // Update selected element on tap
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Button', style: TextStyle(color: Colors.black)),
                                ),
                              )
                            else if (selectedElement == "Icon")
                                GestureDetector(
                                  onTap: () => updateSelectedElement("Icon"), // Update selected element on tap
                                  child: const Icon(Icons.star, size: 40,color: Colors.white,),
                                ),
                          ],
                        ],
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
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      color: Colors.blue.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          elements[index],
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          elements[index],
                          style: const TextStyle(color: Colors.white, fontSize: 18),
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
}
