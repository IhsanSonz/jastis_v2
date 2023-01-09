part of 'models.dart';

class ResponseModel<T> {
  ResponseModel({
    this.success = false,
    this.message = 'Error on sending request',
    this.token,
  });

  bool success;
  String message;
  String? token;
  late T data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        success: json['success'],
        message: json['message'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'token': token,
      };
}
