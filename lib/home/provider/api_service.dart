import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skyfeeduser/home/model/media_model.dart';

class ApiService {
  final String apiUrl = "https://u2nsj6qqm1.execute-api.us-east-1.amazonaws.com/prod/media";

  Future<List<MediaModel>> fetchMedia() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = List<String>.from(json.decode(response.body));
      return jsonResponse.map((url) => MediaModel(url: url)).toList();
    } else {
      throw Exception("Failed to load media");
    }
  }
}
