class ApiSettings{
  static const String _baseUri = 'http://demo-api.mr-dev.tech/api/';
  static const String users = '${_baseUri}users';
  static const String login = '${_baseUri}students/auth/login';
  static const String register = '${_baseUri}students/auth/register';
  static const String logout = '${_baseUri}students/auth/logout';
  static const String image = '${_baseUri}student/images/{id}';
}