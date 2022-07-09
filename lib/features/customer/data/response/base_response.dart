class BaseResponse {
  BaseResponse(
      {this.status,
      this.timeStamp = "",
      required this.message,
      this.data,
      this.statusCode});

  int? statusCode;
  String? status;
  String timeStamp;
  String message;
  dynamic data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        status: json["status"],
        timeStamp: json["timestamp"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "timestamp": timeStamp,
        "message": message,
        "data": data,
      };
}
