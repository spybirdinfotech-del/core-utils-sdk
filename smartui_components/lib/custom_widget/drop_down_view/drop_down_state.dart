
class DropdownState<T>{
  final bool isOpen;
  final List<T> filteredItems;
  final List<T> multiList;
  final String searchText;

  const DropdownState({
    this.isOpen = false,
    required this.filteredItems,
    required this.multiList,
    this.searchText = "",
  });

  DropdownState<T> copyWith({
    bool? isOpen,
    List<T>? filteredItems,
    List<T>? multiList,
    String? searchText,
  }) {
    return DropdownState<T>(
      isOpen: isOpen ?? this.isOpen,
      filteredItems: filteredItems ?? this.filteredItems,
      multiList: multiList ?? this.multiList,
      searchText: searchText ?? this.searchText,
    );
  }

  List<Object?> get props => [isOpen, filteredItems, multiList, searchText];
}
