class AppConfig {
  final String _nameApp = 'Seguridad USM';
  final String _apiHost = 'http://10.0.2.2:3000/api/';
  final String _hereApiHost = 'https://router.hereapi.com/v8/routes';
  final String _searchHereApi = '.search.hereapi.com/v1/';

  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();

  static AppConfig get instance => _instance;
  String get nameApp => _nameApp;
  String get apiHost => _apiHost;
  String get hereApiHost => _hereApiHost;
  String get searchHereApi => _searchHereApi;

  // void init({
  //   required String nameApp,
  //   required String apiHost,
  //   required String hereApiHost,
  //   required String searchHereApi,
  // }){
  //   _nameApp = nameApp;
  //   _apiHost = apiHost;
  //   _hereApiHost = hereApiHost;
  //   _searchHereApi = searchHereApi;
  // }
}