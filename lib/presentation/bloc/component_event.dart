part of 'component_bloc.dart';

abstract class ElementEvent extends Equatable {
  const ElementEvent();
}

class SelectElementEvent extends ElementEvent {
  final SelectedElement selectedElement;

  const SelectElementEvent(this.selectedElement);

  @override
  List<Object?> get props => [selectedElement];
}

class DeselectElementEvent extends ElementEvent {
  @override
  List<Object?> get props => [];
}
