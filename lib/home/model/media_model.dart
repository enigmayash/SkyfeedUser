class MediaModel {
  final String url;

  MediaModel({required this.url});

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      url: json['url'],  // Adjust key based on your API response
    );
  }
}
