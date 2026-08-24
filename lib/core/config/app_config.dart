import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'env_config.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();
  
  factory AppConfig() => _instance;
  
  AppConfig._internal();

  late EnvConfig config;

  Future<void> initialize(AppEnvironment environment) async {
    String fileName;
    switch (environment) {
      case AppEnvironment.dev:
        fileName = 'assets/app.env';
        break;
      case AppEnvironment.staging:
        fileName = 'assets/app_staging.env';
        break;
      case AppEnvironment.prod:
        fileName = 'assets/app_prod.env';
        break;
    }

    await dotenv.load(fileName: fileName);

    config = EnvConfig(
      environmentName: dotenv.get('ENVIRONMENT_NAME', fallback: 'Unknown'),
      baseUrl: dotenv.get('BASE_URL', fallback: ''),
      apiKey: dotenv.get('API_KEY', fallback: ''),
    );
  }

  String get baseUrl => config.baseUrl;
  String get environmentName => config.environmentName;
  String get apiKey => config.apiKey;
}
