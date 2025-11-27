class BaseResponse<T> {
  final int? status;
  final String? timestamp;
  final String? message;
  final String? details;
  final String? path;
  final T? data;

  BaseResponse({
    this.status,
    this.timestamp,
    this.details,
    this.message,
    this.path,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, [T Function(dynamic)? createData]) {
    return BaseResponse(
      status: json['status'],
      message: json['message'],
      timestamp: json['timestamp'],
      details: json['details'],
      path: json['path'],
      data: json['data'] != null && createData != null ? createData(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      'status': status,
      'timestamp': timestamp,
      'details': details,
      'path': path,
      'message': message,
      'data': data,
    };

    if (data != null) {
      json['data'] = (data as dynamic).toJson();
    }

    return json;
  }

  bool mIsDataNotNull() {
    return data != null;
  }
}
