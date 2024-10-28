part of 'component_bloc.dart';

abstract class ComponentEvent extends Equatable {
  const ComponentEvent();
}

class SelectComponentEvent extends ComponentEvent {
  final Component selectedComponent;

  const SelectComponentEvent(this.selectedComponent);

  @override
  List<Object?> get props => [selectedComponent];
}

class DeselectComponentEvent extends ComponentEvent {
  @override
  List<Object?> get props => [];
}

class UpdateComponentEvent extends ComponentEvent {
  final StyleModel newStyle;

  const UpdateComponentEvent(this.newStyle);

  @override
  List<Object?> get props => [newStyle];
}
