import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightSideMenu extends StatefulWidget {
  final List<String> elements;

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
      backgroundColor: Colors.grey,
      child: Column(
        children: [
          const Text("Add UI Elements"),
          const Divider(color: Colors.white),
          Expanded(
            child: ListView.builder(
              itemCount: widget.elements.length,
              itemBuilder: (context, index) {
                return Draggable<String>(
                  data: widget.elements[index],
                  feedback: Material(
                    color: Colors.transparent,
                    child: Text(
                      widget.elements[index],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  child: ListTile(
                    title: Text(widget.elements[index]),
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
