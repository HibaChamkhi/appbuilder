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
      print('state.selectedElement.id:: ${state.selectedElement?.id}');
    });

    on<DeselectElementEvent>((event, emit) {
      emit(state.copyWith(selectedElement: null));
    });

    on<AddDraggableItemEvent>((event, emit) async {
      final updatedDraggableItems =
      List<SelectedElement>.from(state.draggableItems ?? []);

      // Wrap the new element in a GestureDetector
      final newElement = SelectedElement(
        id: event.selectedElement.id,
        type: event.selectedElement.type,
        widget: wrapWithGestureDetector(event.selectedElement.widget, () {
          add(SelectElementEvent(event.selectedElement));
        }),
        isLayout: event.selectedElement.isLayout,
        layoutParent: event.selectedElement.layoutParent, // Optional layoutParent
      );

      if (updatedDraggableItems.isNotEmpty) {
        final lastElement = updatedDraggableItems.last;

        // If last element has no layoutParent, show layout selection
        if (lastElement.layoutParent == null) {
          // Wait for layout selection callback from the UI
          final selectedLayout = await Future.value(); // Wait for the UI to return layout choice

          lastElement.layoutParent = selectedLayout;
          newElement.layoutParent = selectedLayout;

          // Update the last element in the list
          updatedDraggableItems[updatedDraggableItems.length - 1] = lastElement;
        }
      }

      // Add new element
      updatedDraggableItems.add(newElement);

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
              print("Tapped on: ${element.widget}");
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

    on<SelectLayoutForElementEvent>((event, emit) {
      final updatedDraggableItems = List<SelectedElement>.from(state.draggableItems ?? []);

      if (updatedDraggableItems.isNotEmpty) {
        // Apply the selected layout to both the last and current elements
        final lastElement = updatedDraggableItems.last;

        if (lastElement.layoutParent == null) {
          lastElement.layoutParent = event.layout; // Apply layout to last element

          if (state.selectedElement != null) {
            state.selectedElement!.layoutParent = event.layout; // Apply layout to selected element
          }

          // Update the last element in the list
          updatedDraggableItems[updatedDraggableItems.length - 1] = lastElement;

          emit(state.copyWith(draggableItems: updatedDraggableItems));
        }
      }
    });
  }
}

Widget wrapWithGestureDetector(Widget widget, Function onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: widget,
  );
}
