import 'package:flutter/material.dart';
import 'package:app_builder/presentation/style_model.dart';

/// Base Component class representing UI components in the app builder.
class Component {
  final String type; // e.g., 'text', 'icon', 'button', etc.
  StyleModel styleModel; // Stores the style properties for the component.
  Widget? child; // Holds the generated widget for display.
  String? childCode; // Code representation of the widget (optional).

  bool isSelected = false; // Track selection state.
  final bool isLayout; // Whether the component is a layout type (e.g., Row, Column).

  final Function(bool)? onSelectionChange; // Callback for selection changes.

  Component({
    required this.type,
    required this.styleModel,
    this.onSelectionChange,
    this.child,
    this.isLayout = false,
  }) {
    // Initialize the child when the component is created.
    if (!isLayout) {
      createChild();
    }
  }

  /// Method to dynamically create the child widget based on the component type.
  void createChild() {
    child = buildChild();
  }

  /// Method to update the child widget when styles are modified.
  void updateChild(StyleModel newStyleModel) {
    styleModel = newStyleModel;
    createChild(); // Rebuild child with new styles.
  }

  /// Select this component (trigger visual change or callback).
  void select() {
    isSelected = true;
    if (onSelectionChange != null) {
      onSelectionChange!(true);
    }
  }

  /// Deselect this component.
  void deselect() {
    isSelected = false;
    if (onSelectionChange != null) {
      onSelectionChange!(false);
    }
  }

  /// Core method to build the child widget based on the type of component.
  Widget buildChild() {
    switch (type) {
      case 'text':
        return _buildTextComponent();
      case 'icon':
        return _buildIconComponent();
      case 'button':
        return _buildButtonComponent();
      default:
        return const Text('Unknown Component');
    }
  }

  /// Helper method to build a text component.
  Widget _buildTextComponent() {
    childCode = "Text('Sample Text', style: TextStyle(color: ${styleModel.color}, fontSize: ${styleModel.fontSize}))";
    return GestureDetector(
      onTap: () {
        print('Tapped Text: ${childCode ?? 'No code available'}');
      },
      child: MouseRegion(
        onEnter: (_) => select(),
        onExit: (_) => deselect(),
        child: Container(
          decoration: _getSelectionDecoration(),
          child: Text(
            'Sample Text',
            style: TextStyle(
              color: styleModel.color,
              fontSize: styleModel.fontSize,
            ),
          ),
        ),
      ),
    );
  }

  /// Helper method to build an icon component.
  Widget _buildIconComponent() {
    childCode = "Icon(Icons.star, color: ${styleModel.color}, size: ${styleModel.iconSize})";
    return GestureDetector(
      onTap: () {
        print('Tapped Icon: ${childCode ?? 'No code available'}');
      },
      child: MouseRegion(
        onEnter: (_) => select(),
        onExit: (_) => deselect(),
        child: Container(
          decoration: _getSelectionDecoration(),
          child: Icon(
            Icons.star,
            color: styleModel.color,
            size: styleModel.iconSize,
          ),
        ),
      ),
    );
  }

  /// Helper method to build a button component.
  Widget _buildButtonComponent() {
    childCode = "ElevatedButton(onPressed: () {}, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(${styleModel.color}), padding: MaterialStateProperty.all(${styleModel.padding})), child: Text('Button'))";
    return GestureDetector(
      onTap: () {
        print('Tapped Button: ${childCode ?? 'No code available'}');
      },
      child: MouseRegion(
        onEnter: (_) => select(),
        onExit: (_) => deselect(),
        child: Container(
          decoration: _getSelectionDecoration(),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(styleModel.color),
              padding: MaterialStateProperty.all(styleModel.padding),
            ),
            child: const Text('Button'),
          ),
        ),
      ),
    );
  }

  /// Helper method to highlight a selected component with a border.
  BoxDecoration _getSelectionDecoration() {
    return BoxDecoration(
      border: isSelected ? Border.all(color: Colors.blueAccent, width: 2) : null,
    );
  }
}

class LayoutComponent extends Component {
  List<Component> children;
  final Axis layoutDirection; // Horizontal or Vertical
  final bool isStacked;

  LayoutComponent({
    required StyleModel styleModel,
    required this.children,
    this.layoutDirection = Axis.vertical,
    this.isStacked = false,
  }) : super(
    type: 'layout', // Since this is a layout, type is fixed.
    styleModel: styleModel,
    isLayout: true,
  );

  @override
  Widget buildChild() {
    // Build layout based on whether it's a stack or a row/column layout.
    return isStacked
        ? Stack(children: children.map((c) => c.buildChild()).toList())
        : (layoutDirection == Axis.vertical
        ? Column(children: children.map((c) => c.buildChild()).toList())
        : Row(children: children.map((c) => c.buildChild()).toList()));
  }

  /// Add a child component to the layout.
  void addChild(Component child) {
    children.add(child);
  }

  /// Remove a child component from the layout.
  void removeChild(Component child) {
    children.remove(child);
  }
}
