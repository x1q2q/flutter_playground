import 'network.dart';
import 'package:flutter/material.dart';
import '../models/playlists.dart';

class Repositories {
  final NetworkService _networkService;

  Repositories(this._networkService);

  Future<List<Playlists>> getPlaylists() async {
    final response = await _networkService
        .fetchData('users/313apkfk7d5snyhnr52rr2xvbfba/playlists');
    if (response.statusCode == 200) {
      final Map result = Map.from(response.data);
      final List<dynamic> jsonResults = result['items'];
      List<Playlists> playlists = List.generate(jsonResults.length, (j) {
        return Playlists(
            id: jsonResults[j]["id"],
            name: jsonResults[j]['name'],
            href: jsonResults[j]['href']);
      });
      return playlists;
    } else {
      debugPrint('ERRRRO SURR');
      print('error');
      throw Exception('Failed to load playlists data');
    }
  }
}
