import 'package:smartui_components/custom_widget/drop_down_view/drop_down_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownCubit<T> extends Cubit<DropdownState<T>> {
  final List<T> allItems;
  final String Function(T item) displayText;

  DropdownCubit({
    required this.allItems,
    required this.displayText,
    List<T>? selectedItems,
  }) : super(
    DropdownState<T>(
      filteredItems: allItems,
      multiList: selectedItems ?? [],
    ),
  );

  void open() => emit(state.copyWith(isOpen: true));
  void closeDropdown() => emit(state.copyWith(isOpen: false));

  void toggle() =>
      emit(state.copyWith(isOpen: !state.isOpen));

  void search(String value) {
    final list = allItems
        .where((e) => displayText(e).toLowerCase().contains(value.toLowerCase()))
        .toList();

    emit(state.copyWith(
      filteredItems: list,
      searchText: value,
    ));
  }

  void toggleMultiSelection(T item) {
    final updated = List<T>.from(state.multiList);
    updated.contains(item) ? updated.remove(item) : updated.add(item);

    emit(state.copyWith(multiList: updated));
  }
}
