import 'package:flutter_bloc/flutter_bloc.dart';

class CustomListState {
  final int itemCount;
  final bool isLoadingMore;

  CustomListState({
    required this.itemCount,
    this.isLoadingMore = false,
  });

  CustomListState copyWith({
    int? itemCount,
    bool? isLoadingMore,
  }) {
    return CustomListState(
      itemCount: itemCount ?? this.itemCount,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class CustomListCubit extends Cubit<CustomListState> {
  CustomListCubit() : super(CustomListState(itemCount: 10));

  //pagination
  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(
      itemCount: state.itemCount + 10,
      isLoadingMore: false,
    ));
  }
}
