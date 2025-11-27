class GoogleFCMResponse {
  String? applicationId;
  String? apiKey;
  String? projectId;

  GoogleFCMResponse({this.applicationId, this.apiKey, this.projectId});

  GoogleFCMResponse.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'] ?? '';
    apiKey = json['apiKey'] ?? '';
    projectId = json['projectId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicationId'] = applicationId;
    data['apiKey'] = apiKey;
    data['projectId'] = projectId;
    return data;
  }
}