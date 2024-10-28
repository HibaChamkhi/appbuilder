part of 'component_bloc.dart';

class ComponentState extends Equatable {
  final SelectedElement? selectedElement;
  final List<SelectedElement>? draggableItems;

  const ComponentState({this.selectedElement, this.draggableItems});

  ComponentState copyWith({
    SelectedElement? selectedElement,
    List<SelectedElement>? draggableItems,
  }) {
    return ComponentState(
      selectedElement: selectedElement ?? this.selectedElement,
      draggableItems: draggableItems ?? [],
    );
  }

  @override
  List<Object?> get props => [
        selectedElement,
        draggableItems,
      ];
}
