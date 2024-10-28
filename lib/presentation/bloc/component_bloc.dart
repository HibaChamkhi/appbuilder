import 'package:app_builder/presentation/type_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'component_state.dart';
part 'component_event.dart';

class ComponentBloc extends Bloc<ElementEvent, ComponentState> {
  ComponentBloc() : super(const ComponentState()) {
    on<SelectElementEvent>((event, emit) {
      emit(state.copyWith(selectedElement: event.selectedElement));
    });

    on<DeselectElementEvent>((event, emit) {
      emit(state.copyWith(selectedElement: null));
    });
  }
}