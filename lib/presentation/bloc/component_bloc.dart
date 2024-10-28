import 'package:app_builder/presentation/type_model.dart';
import 'package:flutter/cupertino.dart';
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

    on<AddDraggableItemEvent>((event, emit) {
      final SelectedElement element = SelectedElement(
        type: event.selectedElement.type,
        widget: wrapWithGestureDetector(event.selectedElement.widget, () {
          // add(SelectElementEvent(selectedElement));
          print("Tapped on: ${event.selectedElement.id}");
        }),
        isLayout: event.selectedElement.isLayout,
      );
      final updatedDraggableItems =
          List<SelectedElement>.from(state.draggableItems ?? [])
            ..add(element);

      emit(state.copyWith(
          draggableItems: updatedDraggableItems,
          selectedElement: element));
      print("state.selectedElement?.id ${state.selectedElement?.id}");
    });

    on<EditDraggableItemEvent>((event, emit) {
      final updatedDraggableItems = state.draggableItems?.map((element) {
        if (element.id == event.selectedElement.id) {
          return event.selectedElement;
        }
        return element;
      }).toList();

      emit(state.copyWith(draggableItems: updatedDraggableItems));
      print('bloc:::: ${state.selectedElement?.id}');
      print('bloc:::: ${state.selectedElement?.widget}');
    });

    // Utility functions
    // Widget wrapWithGestureDetector(Widget widget, Function onTap) {
    //   return GestureDetector(
    //     onTap: () => onTap(),
    //     child: widget,
    //   );
    // }

    // SelectedElement createComponent(
    //   SelectedElement selectedElement,
    // ) {
    //   Widget wrappedWidget =
    //       wrapWithGestureDetector(selectedElement.widget, () {
    //     // add(SelectElementEvent(selectedElement));
    //     print("Tapped on: ${selectedElement.id}");
    //   });
    //
    //   return SelectedElement(
    //     type: selectedElement.type,
    //     widget: wrapWithGestureDetector(selectedElement.widget, () {
    //       // add(SelectElementEvent(selectedElement));
    //       print("Tapped on: ${selectedElement.id}");
    //     }),
    //     isLayout: selectedElement.isLayout,
    //   );
    // }
  }
}
Widget wrapWithGestureDetector(Widget widget, Function onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: widget,
  );
}