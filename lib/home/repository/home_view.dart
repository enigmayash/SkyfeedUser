import 'package:flutter/material.dart';
import 'package:skyfeeduser/home/model/media_model.dart';
import 'package:skyfeeduser/home/provider/api_service.dart';


class HomeViewModel extends ChangeNotifier {
  final ApiService apiService;
  List<MediaModel> mediaList = [];
  bool isLoading = false;

  HomeViewModel({required this.apiService});

  Future<void> fetchMediaFiles() async {
    isLoading = true;
    notifyListeners();

    try {
      mediaList = await apiService.fetchMedia();
    } catch (e) {
      // Handle errors
      print("Error fetching media: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
