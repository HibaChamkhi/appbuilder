part of 'component_bloc.dart';

class ComponentState extends Equatable {
  final SelectedElement? selectedElement;

  const ComponentState({this.selectedElement});

  ComponentState copyWith({
    SelectedElement? selectedElement,
  }) {
    return ComponentState(
      selectedElement: selectedElement ?? this.selectedElement,
    );
  }

  @override
  List<Object?> get props => [
        selectedElement,
      ];
}
