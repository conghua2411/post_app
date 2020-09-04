/// command line run project: flutter run --dart-define=ENDPOINT_PROD=$endpoint
/// endpoint = 'endpoint production'

class Env {
  static const ENDPOINT = String.fromEnvironment(
    'ENDPOINT_PROD',
    defaultValue: 'https://jsonplaceholder.typicode.com',
  );
}
