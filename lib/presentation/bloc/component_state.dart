part of 'component_bloc.dart';

abstract class ComponentState extends Equatable {
  const ComponentState();
}

class ComponentInitial extends ComponentState {
  @override
  List<Object?> get props => [];
}

class ComponentSelected extends ComponentState {
  final Component selectedComponent;

  const ComponentSelected(this.selectedComponent);

  @override
  List<Object?> get props => [selectedComponent];
}

class ComponentDeselected extends ComponentState {
  @override
  List<Object?> get props => [];
}
