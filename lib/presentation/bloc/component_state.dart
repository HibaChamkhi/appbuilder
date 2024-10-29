part of 'component_bloc.dart';

class ComponentState extends Equatable {
  final SelectedElement? selectedElement;
  late  bool showScreenParameters;
  final List<SelectedElement>? draggableItems;

   ComponentState({
    this.selectedElement,
    this.draggableItems,
    this.showScreenParameters = true,
  });

  ComponentState copyWith({
    SelectedElement? selectedElement,
    bool? showScreenParameters,
    List<SelectedElement>? draggableItems,
  }) {
    return ComponentState(
      selectedElement: selectedElement ?? this.selectedElement,
      draggableItems: draggableItems ?? this.draggableItems,
      showScreenParameters: showScreenParameters ?? true,
    );
  }

  @override
  List<Object?> get props => [
        selectedElement,
        draggableItems,
        showScreenParameters,
      ];
}
