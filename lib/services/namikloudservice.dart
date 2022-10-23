part of 'services.dart';

class NamikloudService {
  static Future<http.Response> sendMail(String email) {
    return http.post(Uri.https(Const.baseUrl, "/Week5/api/Mahasiswa/sendmail"),
        headers: <String, String>{
          'Content-Type': 'application/json;'
              'charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
        }));
  }
}
