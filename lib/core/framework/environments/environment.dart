class EnvironmentSetup {
  static void run({required Environment environment}) {
    env = environment;
  }

  static late Environment env;

  static String get baseUrl => env == Environment.live ? _liveUrl : _testUrl;

  static final String _liveUrl =
      "https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1".trim();
  static final String _testUrl =
      "https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1".trim();
}

enum Environment { live, dev }
