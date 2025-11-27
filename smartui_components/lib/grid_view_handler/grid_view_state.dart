class GridViewState {
  final bool isLoading;
  final List<dynamic> items; // Generic items
  final String? error;

  GridViewState({
    this.isLoading = false,
    this.items = const [],
    this.error,
  });

  GridViewState copyWith({
    bool? isLoading,
    List<dynamic>? items,
    String? error,
  }) {
    return GridViewState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error,
    );
  }
}