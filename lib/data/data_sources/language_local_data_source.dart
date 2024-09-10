abstract class LanguageLocalDataSource {
  Future<void> updateLanguage(String languageCode);
  Future<String> getPreferredLanguage();
  Future<void> updateTheme(String themeName);
  Future<String> getPreferredTheme();
}

class LanguageLocalDataSourceImpl extends LanguageLocalDataSource {
  @override
  Future<String> getPreferredLanguage() async {
    return 'en';
  }

  @override
  Future<String> getPreferredTheme() async {
    return 'dark';
  }

  @override
  Future<void> updateLanguage(String languageCode) {
    // TODO: implement updateLanguage
    throw UnimplementedError();
  }

  @override
  Future<void> updateTheme(String themeName) {
    // TODO: implement updateTheme
    throw UnimplementedError();
  }

}