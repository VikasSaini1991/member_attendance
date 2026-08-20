enum AppEnvironment {
  dev,
  staging,
  prod,
}

class EnvConfig {
  final String environmentName;
  final String baseUrl;
  final String apiKey;

  EnvConfig({
    required this.environmentName,
    required this.baseUrl,
    required this.apiKey,
  });
}
