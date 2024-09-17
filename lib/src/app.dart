import 'package:flutter/material.dart';
import 'utils/util.dart';
import 'utils/theme.dart';
// import 'stepper_page.dart';
// import 'animated_btn.dart';
// import 'chat_message.dart';
import 'spotify_page.dart';
import 'services/network.dart';
import 'services/repositories.dart';
import 'create_playlist_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final networkServices = NetworkService();
    final repos = Repositories(networkServices);
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Outfit", "ABeeZee");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: SpotifyPage(repos: repos));
    // home: CreatePlaylistPage());
  }
}
