import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SelectedElement {
  late final String id; // Non-nullable
  final Type type;
  late final Widget widget;
  final bool isLayout;
  Map<String, dynamic>? params;
  Type? layoutParent; // New property to indicate layout relationship


  SelectedElement({
    required this.type,
    required this.widget,
    this.isLayout = false,
    this.layoutParent, // Add layoutParent as an optional named parameter
    String? id, // Add id as an optional named parameter
  }) : id = id ?? Uuid().v4(); // Use the provided id or generate a new one

  // Convert a SelectedElement into a Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(), // Convert Type to String
      'isLayout': isLayout,
      'layoutParent': layoutParent?.toString(), // Convert layoutParent to String
    };
  }

  // Convert a Map into a SelectedElement.
  factory SelectedElement.fromJson(Map<String, dynamic> json) {
    return SelectedElement(
      type: _typeFromString(json['type']),
      widget: json['widget'], // Handle widget conversion as necessary
      isLayout: json['isLayout'],
      layoutParent: _typeFromString(json['layoutParent']), // Convert layoutParent
    )..id = json['id']; // Assign the id after construction
  }

  // Helper method to convert string back to Type
  static Type _typeFromString(String typeString) {
    switch (typeString) {
      case 'Text':
        return Text; // Return the appropriate Type
      case 'Icon':
        return Icon; // Return the appropriate Type
      case 'Column':
        return Column;
      case 'Row':
        return Row;
      case 'Stack':
        return Stack;      default:
        throw Exception('Unknown type: $typeString');
    }
  }




  Map<String, dynamic> extractParams() {
    if (type == Text) {
      final textWidget = widget as Text;
      return {
        'text': textWidget.data ?? '',
        'style': textWidget.style,
      };
    } else if (type == Icon) {
      final iconWidget = widget as Icon;
      return {
        'color': iconWidget.color,
        'size': iconWidget.size,
      };
    }
    // Add more cases for other widgets
    return {};
  }


}


final typeToWidgetMap = {
  Text: const Text(
    "This is a text",
    style: TextStyle(fontSize: 20, color: Colors.red,),
  ),
  Icon: const Icon(
    Icons.star,
    size: 20,
    color: Colors.red,
  ),
};