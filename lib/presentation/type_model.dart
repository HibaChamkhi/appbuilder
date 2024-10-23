import 'package:flutter/material.dart';

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