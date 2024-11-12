import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skyfeeduser/home/model/media_model.dart';

class ApiService {
  final String apiUrl = "https://your-api-id.execute-api.region.amazonaws.com/prod/media";

  Future<List<MediaModel>> fetchMedia() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => MediaModel.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load media");
    }
  }
}
