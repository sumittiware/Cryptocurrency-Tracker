import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRequest {
  static const baseUrl = 'https://api.coincap.io/v2/';

  static Future<List<dynamic>> get({
    String endPoint = '',
    dynamic body,
  }) async {
    try {
      final url = Uri.parse(baseUrl + endPoint);
      final response = await http.get(
        url,
      );

      if (response.statusCode == 400) {
        throw Exception('Bad Request');
      }

      if (response.statusCode > 400 && response.statusCode <= 417) {
        throw Exception('Client Error');
      }

      final result = json.decode(response.body);

      return result['data'];
    } catch (err) {
      throw Exception('Something went wrong!');
    }
  }
}
