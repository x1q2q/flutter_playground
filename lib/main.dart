import 'package:flutter/material.dart';
// import 'stepper_page.dart';
// import 'animated_btn.dart';
// import 'chat_message.dart';
import 'spotify_page.dart';
import 'services/network.dart';
import 'services/repositories.dart';
import 'create_playlist_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final networkServices = NetworkService();
    // final repos = Repositories(networkServices);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: '',
            colorScheme: const ColorScheme.light()
                .copyWith(primary: Colors.blue[400], secondary: Colors.teal)),
        // home: SpotifyPage(repos: repos));
        home: CreatePlaylistPage());
  }
}
