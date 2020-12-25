import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

// class to get list of data
class ApiBackend {
  Future<DataModel> getApiData(String paginatedUrl) async {
    return http
        .get(
      Uri.encodeFull(paginatedUrl),
    )
        .then((http.Response response) {
      final data = DataModel.fromJson(jsonDecode(response.body));
      return data;
    });
  }
}
