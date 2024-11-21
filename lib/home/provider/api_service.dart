import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skyfeeduser/home/model/media_model.dart';

class ApiService {
  final String apiUrl = "https://u2nsj6qqm1.execute-api.us-east-1.amazonaws.com/prod/media";

  Future<List<MediaModel>> fetchMedia() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = List<String>.from(json.decode(response.body));
      return jsonResponse.map((url) {
        String httpUrl = convertS3UrlToHttp(url);
        return MediaModel(url: httpUrl);
      }).toList();
    } else {
      throw Exception("Failed to load media");
    }
  }
  String convertS3UrlToHttp(String s3Url) {
    final uri = Uri.parse(s3Url.replaceFirst('s3://', ''));
    final bucketName = uri.host; // This is the bucket name
    final path = uri.path; // This is the path to the file

    return 'https://$bucketName.s3.amazonaws.com$path';
  }
}
