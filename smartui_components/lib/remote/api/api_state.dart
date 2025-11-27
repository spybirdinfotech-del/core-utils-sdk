class ApiState {
  final bool isLoading;
  final dynamic data;
  final String? errorMessage;
  final String? extendedDetails;

  const ApiState({
    this.isLoading = false,
    this.data,
    this.errorMessage,
    this.extendedDetails,
  });

  factory ApiState.initial() => const ApiState();

  factory ApiState.loading() => const ApiState(isLoading: true);

  factory ApiState.success(dynamic data) => ApiState(data: data);

  factory ApiState.error(String message, [String? details]) =>
      ApiState(errorMessage: message, extendedDetails: details);

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
  bool get hasData => data != null;
}

