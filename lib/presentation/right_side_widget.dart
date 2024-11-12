import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightSideMenu extends StatefulWidget {
  final List<Map<String, dynamic>> elements;

  const RightSideMenu({
    super.key,
    required this.elements,
  });

  @override
  _RightSideMenuState createState() => _RightSideMenuState();
}

class _RightSideMenuState extends State<RightSideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      backgroundColor: const Color(0xffe5e1e7),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns in the grid
                crossAxisSpacing: 1.0, // Spacing between columns
                childAspectRatio: 1, // Adjusts the height of each cell
              ),
              itemCount: widget.elements.length,
              itemBuilder: (context, index) {
                return Draggable<String>(
                  data: widget.elements[index]['name'],
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        widget.elements[index]['name'],
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(widget.elements[index]['icon']),
                        const SizedBox(height: 5),
                        Text(widget.elements[index]['name']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
