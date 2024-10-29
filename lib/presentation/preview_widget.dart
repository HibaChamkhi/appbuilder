import 'package:app_builder/presentation/type_model.dart';
import 'package:app_builder/utils/create_component.dart';
import 'package:app_builder/utils/wrap_with_parent.dart';
import 'package:flutter/material.dart';

// PreviewWidget Code
class PreviewWidget extends StatefulWidget {
  final double selectedHeight;
  final double selectedWidth;
  final Color selectedColor;
  final List<SelectedElement> draggableItems;
  final Function() resetSelection;
  // final Function(SelectedElement) tapElement;
  final Function(SelectedElement) addElement;
  final Color elementColor;

  const PreviewWidget({
    Key? key,
    required this.selectedHeight,
    required this.selectedWidth,
    required this.selectedColor,
    required this.draggableItems,
    // required this.tapElement,
    required this.resetSelection,
    required this.addElement,
    required this.elementColor,
  }) : super(key: key);

  @override
  State<PreviewWidget> createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // widget.resetSelection();
        },
        child: Center(
          child: Container(
            height: widget.selectedHeight,
            width: widget.selectedWidth,
            color: Colors.white,
            child: Stack(
              children: [
                DragTarget<SelectedElement>(
                  onAccept: (data) {
                    print('data::: $data');
                    if (widget.draggableItems.isNotEmpty) {
                      var existingComponent = widget.draggableItems.last;

                      if (existingComponent.isLayout == true) {
                        setState(() {
                          // final newComponent = createComponent(data,);
                          // existingComponent = wrapWithParent(
                          //   existingComponent: existingComponent,
                          //   newComponent: data,
                          // );
                          widget.draggableItems[widget.draggableItems.length - 1] = existingComponent;
                        });
                      } else {
                        _showLayoutDialog(existingComponent, data);
                      }
                    } else {
                      widget.addElement(data);
                      // print(" widget.tapElement ${widget.tapElement}");

                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    if (widget.draggableItems.isEmpty) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_box_outlined, color: Colors.white, size: 40),
                          Text("Empty Screen", style: TextStyle(color: Colors.white)),
                          Text(
                            "Drag a layout element from the left to get started" ,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    }
                    return Stack(
                      children: widget.draggableItems.map((component) {
                        return Positioned(
                          left: 20.0 * widget.draggableItems.indexOf(component),
                          top: 20.0 * widget.draggableItems.indexOf(component),
                          // child: GestureDetector(
                            // onTap: () => widget.tapElement(component),
                            child: buildComponent(component.widget),
                          // ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLayoutDialog(SelectedElement existingComponent, SelectedElement newData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Layout'),
          content: const Text('How would you like to arrange the elements?'),
          actions: [
            TextButton(
              onPressed: () {
                // final newComponent = createComponent(newData);
                widget.draggableItems.removeLast();
                widget.addElement(wrapWithRow(
                  firstComponent: existingComponent,
                  secondComponent: newData,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Row'),
            ),
            TextButton(
              onPressed: () {
                // final newComponent = createComponent(newData);
                widget.draggableItems.removeLast();
                widget.addElement(wrapWithColumn(
                  firstComponent: existingComponent,
                  secondComponent: newData,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Column'),
            ),
            TextButton(
              onPressed: () {
                // final newComponent = createComponent(newData,);
                widget.draggableItems.removeLast();
                widget.addElement(wrapWithStack(
                  firstComponent: existingComponent,
                  secondComponent: newData,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Stack'),
            ),
          ],
        );
      },
    );
  }
}