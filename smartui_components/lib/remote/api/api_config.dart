class ApiConfig {
  final String? refreshTokenApi;
  final void Function()? onLogout;
  final Future<dynamic> Function(String message, String extendedDetails)? errorDialog;

  const ApiConfig({
    this.refreshTokenApi,
    this.onLogout,
    this.errorDialog,
  });
}