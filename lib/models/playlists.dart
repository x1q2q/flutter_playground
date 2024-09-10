class Playlists {
  final String id;
  final String name;
  final String href;
  Playlists({required this.id, required this.name, required this.href});
  factory Playlists.fromJson(Map<String, dynamic> json) {
    return Playlists(id: json['id'], name: json['name'], href: json['href']);
  }
}
