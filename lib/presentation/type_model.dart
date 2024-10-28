import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SelectedElement {
  late final String id; // Non-nullable
  final Type type;
  late final Widget widget;
  final bool isLayout;
  Map<String, dynamic>? params;

  SelectedElement({
    required this.type,
    required this.widget,
    this.isLayout = false,
  }) : id = Uuid().v4(); // Generate a UUID for each instance

  // Convert a SelectedElement into a Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(), // Convert Type to String
      'isLayout': isLayout,
      // Note: You need to handle the widget serialization differently.
    };
  }

  // Convert a Map into a SelectedElement.
  factory SelectedElement.fromJson(Map<String, dynamic> json) {
    return SelectedElement(
      type: _typeFromString(json['type']),
      widget: json['widget'], // Handle widget conversion as necessary
      isLayout: json['isLayout'],
    )..id = json['id']; // Assign the id after construction
  }

  // Helper method to convert string back to Type
  static Type _typeFromString(String typeString) {
    switch (typeString) {
      case 'Text':
        return Text; // Return the appropriate Type
      case 'Icon':
        return Icon; // Return the appropriate Type
    // Add more cases as needed
      default:
        throw Exception('Unknown type: $typeString');
    }
  }
}

final typeToWidgetMap = {
  Text: const Text(
    "This is a text",
    style: TextStyle(fontSize: 20, color: Colors.red),
  ),
  Icon: const Icon(
    Icons.star,
    size: 20,
    color: Colors.red,
  ),
};
