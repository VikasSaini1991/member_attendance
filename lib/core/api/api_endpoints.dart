import '../config/app_config.dart';

class ApiEndpoints {
  static String get baseUrl => AppConfig().baseUrl;
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 15000;

  static const String getMps = "mps";
  static const String verifyOtp = "verify-otp";
}
