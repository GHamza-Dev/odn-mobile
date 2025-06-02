class ApiEndPoints {
  static const bool developpement = false;
  static const String _prodServer = 'http://158.220.114.106';
  static const String _devServer = 'http://158.220.114.106';

  // static const String _prodServer = 'https://ae65-196-117-161-222.ngrok-free.app';
  // static const String _devServer = 'https://ae65-196-117-161-222.ngrok-free.app';


  static String get server {
    return developpement ? _devServer : _prodServer;
  }
  static String get LOGIN => '/api/odn/auth/login';
  static String get LOGOUT => '/api/odn/auth/logout';
  static String get GET_DETAILS_BOITIER => '/api/odn/find';
  static String get SUBMIT => '/api/odn/update';

}
