import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Component> _draggableItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Phone UI Drag and Drop'),
        ),
        body: Center(
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.grey[500],
                    width: 300,
                    height: 600,
                  ),
                  // Phone UI where items can be dropped
                  DragTarget<Offset>(
                    builder: (BuildContext context, List<Offset?> accepted,
                        List<dynamic> rejected) {
                      return Container(
                        width: 300,
                        height: 600,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Stack(
                          children: _draggableItems
                              .map((component) => Positioned(
                            left: component.position.dx,
                            top: component.position.dy,
                            child: _buildPlacedDraggable(
                                component.position),
                          ))
                              .toList(),
                        ),
                      );
                    },
                    onAccept: (offset) {
                      print(offset);
                      setState(() {
                        _draggableItems.add(Component(
                            child: _draggableContainer(), position: offset));
                      });
                    },
                  ),
                ],
              ),
              // Display the initial long-press draggable component
              Positioned(
                left: 50,
                top: 100,
                child: _buildLongPressDraggable(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the long-press draggable component
  Widget _buildLongPressDraggable() {
    return LongPressDraggable<Offset>(
      data: const Offset(10, 0),
      feedback: _draggableContainer(opacity: 0.7),
      childWhenDragging: _draggableContainer(opacity: 0.3),
      onDragEnd: (details) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          Offset localPosition = renderBox.globalToLocal(details.offset);
          print('detailsoffset: ${details.offset}');
          // Add the position relative to the drop area
          // setState(() {
          //   _draggableItems.add(localPosition);
          // });
        }
      },
      child: _draggableContainer(),
    );
  }

  // Function to build draggable components placed inside the phone area
  Widget _buildPlacedDraggable(Offset offset) {
    return Draggable<Offset>(
      data: offset,
      // Pass the current offset as data for future drags
      feedback: _draggableContainer(opacity: 0.7),
      childWhenDragging: _draggableContainer(opacity: 0.3),
      child: _draggableContainer(),
      onDragEnd: (details) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          Offset localPosition = renderBox.globalToLocal(details.offset);

          // Update position if it's dragged and dropped within the phone area
          // setState(() {
          //   _draggableItems.remove(offset);
          //   _draggableItems.add(localPosition);
          // });
        }
      },
    );
  }

  // Function to build the draggable container widget
  Widget _draggableContainer({double opacity = 1.0}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(opacity),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          'Drag Me',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class Component {
  final Offset position;
  final Widget child;

  const Component({required this.child, required this.position});
}
