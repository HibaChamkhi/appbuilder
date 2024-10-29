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

class AddDraggableItemEvent extends ElementEvent {
  final SelectedElement selectedElement;

  const AddDraggableItemEvent(this.selectedElement);

  @override
  List<Object?> get props => [selectedElement];
}

class EditDraggableItemEvent extends ElementEvent {
  final String selectedElementId;
  final Widget selectedElementWidget;

  const EditDraggableItemEvent(this.selectedElementId,this.selectedElementWidget);

  @override
  List<Object?> get props => [selectedElementId,selectedElementWidget];
}
