import 'package:flutter_bloc/flutter_bloc.dart';
import '../component.dart';
import 'package:equatable/equatable.dart';

import '../style_model.dart';

part 'component_state.dart';
part 'component_event.dart';

class ComponentBloc extends Bloc<ComponentEvent, ComponentState> {
  ComponentBloc() : super(ComponentInitial()) {
    on<SelectComponentEvent>((event, emit) {
      emit(ComponentSelected(event.selectedComponent));
    });

    on<DeselectComponentEvent>((event, emit) {
      emit(ComponentDeselected());
    });

    on<UpdateComponentEvent>((event, emit) {
      if (state is ComponentSelected) {
        final selectedComponent = (state as ComponentSelected).selectedComponent;
        selectedComponent.updateChild(event.newStyle);
        emit(ComponentSelected(selectedComponent)); // Emit updated component
      }
    });
  }
}
