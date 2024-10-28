import 'package:flutter/material.dart';

import 'presentation/app_builder_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize bindings
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AppBuilderScreen(),
      ),
    );
  }
}
// import 'package:app_builder/utils/create_component.dart';
// import 'package:flutter/material.dart';
// import 'package:app_builder/presentation/type_model.dart'; // Ensure correct import
// import 'package:uuid/uuid.dart'; // If you need Uuid for other parts
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<SelectedElement> selectedElements = []; // Store multiple SelectedElements
//
//   void create() {
//     // Initial widget
//     Widget initialWidget = Container(
//       width: 100,
//       height: 100,
//       color: Colors.blue,
//       child: Center(child: Text("Initial Widget")),
//     );
//
//     // Create a new SelectedElement
//     SelectedElement newElement = createComponent(
//       SelectedElement(type: Container, widget: initialWidget), // Use the imported SelectedElement
//     );
//     setState(() {
//       selectedElements.add(newElement); // Add to the list
//     });
//   }
//
//   void update(int index) {
//     // New widget to update to
//     Widget newWidget = Container(
//       width: 100,
//       height: 100,
//       color: Colors.green,
//       child: Center(child: Text("Updated Widget")),
//     );
//
//     if (index < selectedElements.length) {
//       // Update the existing SelectedElement
//       selectedElements[index] = updateComponent(selectedElements[index], newWidget: newWidget);
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("Component Update Example")),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Display all selected elements
//               for (var element in selectedElements) ...[
//                 element.widget,
//                 SizedBox(height: 20),
//                 Text('ID: ${element.id}'), // Display the ID for debugging
//               ],
//               ElevatedButton(
//                 onPressed: create,
//                 child: Text("Create Component"),
//               ),
//               // Update the first element as an example
//               ElevatedButton(
//                 onPressed: () => update(0),
//                 child: Text("Update First Component"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//

