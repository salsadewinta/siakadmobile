class ApiUrl {
  static const String baseUrl = 'http://10.0.2.2/akad-api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listMatkul = baseUrl + '/matkul';
  static const String createMatkul = baseUrl + '/matkul';

  static String updateMatkul(int id) {
    return baseUrl + '/matkul/' + id.toString() + '/update';
  }

  static String showMatkul(int id) {
    return baseUrl + '/matkul/' + id.toString();
  }

  static String deleteMatkul(int id) {
    return baseUrl + '/matkul/' + id.toString();
  }
}
