import 'package:app_builder/presentation/type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'component_state.dart';

part 'component_event.dart';

class ComponentBloc extends Bloc<ElementEvent, ComponentState> {
  ComponentBloc() : super(ComponentState()) {
    on<SelectElementEvent>((event, emit) {
      emit(state.copyWith(
          selectedElement: event.selectedElement, showScreenParameters: false));
    });

    on<DeselectElementEvent>((event, emit) {
      emit(state.copyWith(selectedElement: null));
    });

    on<AddDraggableItemEvent>((event, emit) {
      // Find if the element already exists in draggableItems by ID
      final existingIndex = state.draggableItems
          ?.indexWhere((element) => element.id == event.selectedElement.id);

      // If the element exists, replace it; if not, add as a new item
      final updatedDraggableItems =
          List<SelectedElement>.from(state.draggableItems ?? []);
      print('add draggable item: ${event.selectedElement.widget}');
      final newElement = SelectedElement(
        id: event.selectedElement.id,
        type: event.selectedElement.type,
        widget: wrapWithGestureDetector(event.selectedElement.widget, () {
          print("Tapped on: ${event.selectedElement.id}");
          print("Tapped on: ${event.selectedElement.widget}");
          add(SelectElementEvent(event.selectedElement));
        }),
        isLayout: event.selectedElement.isLayout,
      );

      if (existingIndex != null && existingIndex >= 0) {
        updatedDraggableItems[existingIndex] = newElement;
      } else {
        updatedDraggableItems.add(newElement);
      }
      emit(state.copyWith(
        draggableItems: updatedDraggableItems,
        selectedElement: newElement,
      ));
    });

    on<EditDraggableItemEvent>((event, emit) {
      final updatedDraggableItems = state.draggableItems?.map((element) {
        if (element.id == event.selectedElementId) {
          return SelectedElement(
            id: event.selectedElementId,
            type: element.type,
            widget: wrapWithGestureDetector(event.selectedElementWidget, () {
              print("Tapped on: ${element.id}");
              add(SelectElementEvent(element));
            }),
            isLayout: element.isLayout,
          );
        }
        return element;
      }).toList();
      print("updatedDraggableItems ${event.selectedElementWidget}");
      emit(state.copyWith(draggableItems: updatedDraggableItems));
      // print('bloc:::: ${state.selectedElement?.id}');
      // print('bloc:::: ${state.selectedElement?.widget}');
    });
  }
}

Widget wrapWithGestureDetector(Widget widget, Function onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: widget,
  );
}
