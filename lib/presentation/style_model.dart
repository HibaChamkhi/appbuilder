import 'package:flutter/material.dart';

class StyleModel {
  final Color? color;
  final double? fontSize;
  final double? iconSize;
  final EdgeInsets? padding;

  StyleModel({this.color, this.fontSize, this.iconSize, this.padding});

  // This method merges a new StyleModel with the existing one,
  // keeping the old values when new ones are not provided.
  StyleModel copyWith({
    Color? color,
    double? fontSize,
    double? iconSize,
    EdgeInsets? padding,
  }) {
    return StyleModel(
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      iconSize: iconSize ?? this.iconSize,
      padding: padding ?? this.padding,
    );
  }
}