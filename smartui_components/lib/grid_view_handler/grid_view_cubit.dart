import 'package:smartui_components/grid_view_handler/grid_view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridViewCubit extends Cubit<GridViewState> {
  GridViewCubit() : super(GridViewState());

  void loadItems(List<dynamic> data) {
    emit(state.copyWith(isLoading: false, items: data, error: null));
  }

  void setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  void setError(String err) {
    emit(state.copyWith(isLoading: false, error: err));
  }
}