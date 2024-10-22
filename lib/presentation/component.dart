import 'package:flutter/cupertino.dart';

class Component {
  Widget child;
  final bool isLayout;

  Component({required this.child, this.isLayout = false});
}