import 'package:flutter/material.dart';
import 'package:skyfeeduser/home/provider/api_service.dart';
import 'package:skyfeeduser/home/repository/home_view.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart'; // Import Amplify for authentication
import 'package:go_router/go_router.dart'; // Import GoRouter for navigation

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(apiService: ApiService())..fetchMediaFiles(),
      child: Scaffold(
        appBar: AppBar(title: Text("Media Files")),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            // Check if the user is signed in
            return FutureBuilder<AuthSession>(
              future: Amplify.Auth.fetchAuthSession(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final isSignedIn =
                    snapshot.hasData && snapshot.data!.isSignedIn;

                if (!isSignedIn) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Please sign in to view media files."),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            context.go('/signin'); // Navigate to Sign In page
                          },
                          child: Text("Sign In"),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            context.go('/signup'); // Navigate to Sign Up page
                          },
                          child: Text("Sign Up"),
                        ),
                      ],
                    ),
                  );
                }

                // If signed in, show media files
                if (viewModel.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (viewModel.mediaList.isEmpty) {
                  return Center(child: Text("No media files found"));
                }

                return ListView.builder(
                  itemCount: viewModel.mediaList.length,
                  itemBuilder: (context, index) {
                    final media = viewModel.mediaList[index];
                    return ListTile(
                      leading: Icon(Icons.video_library),
                      title: Text(
                          media.url), // Display URL or media name if available
                      onTap: () {
                        context.go('/videoPlayer', extra: media.url);
                      }, // Handle media item click (e.g., play video)
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
