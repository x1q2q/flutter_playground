import 'package:flutter/material.dart';
import 'services/repositories.dart';
import 'models/playlists.dart';
import 'widgets/simple_grid.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SpotifyPage extends StatefulWidget {
  final Repositories repos;
  const SpotifyPage({super.key, required this.repos});

  @override
  State<SpotifyPage> createState() => _SpotifyPageState();
}

class _SpotifyPageState extends State<SpotifyPage> {
  List<Playlists>? playlists = [];
  bool isLoading = true;
  bool hasError = false;
  String error = '';
  @override
  void initState() {
    _handleRefresh();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
      hasError = false;
      error = '';
    });
    await getPlaylists();
  }

  Future<void> getPlaylists() async {
    try {
      playlists = await widget.repos.getPlaylists();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Your Spotify Playlist",
              style: Theme.of(context).textTheme.titleMedium),
        ),
        body: SafeArea(
            child: RefreshIndicator(
                backgroundColor: Colors.teal,
                color: Colors.white,
                strokeWidth: 2.0,
                onRefresh: () async {
                  setState(() {
                    isLoading = true;
                    hasError = false;
                  });
                  await _handleRefresh();
                },
                child: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.teal))
                        : !hasError
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      color: Colors.white,
                                      child: _buildSimpleGrid(context)),
                                  const SizedBox(height: 10),
                                  Expanded(
                                      child:
                                          _buildPlaylists(context, playlists!)),
                                ],
                              )
                            : Column(
                                children: <Widget>[
                                  Text("Error: $error"),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                      onPressed: () async {
                                        _handleRefresh();
                                      },
                                      child: const Text('Refresh Token'))
                                ],
                              )))));
  }

  Widget _buildPlaylists(BuildContext context, List<Playlists>? data) {
    return GlowingOverscrollIndicator(
        showLeading: true,
        showTrailing: true,
        axisDirection: AxisDirection.down,
        color: Colors.teal,
        child: ListView.separated(
            itemCount: data!.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 15),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            itemBuilder: (BuildContext context, int index) {
              Playlists item = data[index];
              return ListTile(
                tileColor: Colors.white,
                leading: IconButton(
                    icon: const Badge(
                        label: Text('Edit'),
                        backgroundColor: Colors.orangeAccent,
                        textColor: Colors.black87,
                        child: PhosphorIcon(PhosphorIconsBold.notePencil,
                            color: Colors.teal, size: 24.0)),
                    onPressed: () {}),
                title: Text(item.name,
                    style: Theme.of(context).textTheme.labelLarge),
                trailing: IconButton(
                    icon: Badge.count(
                        count: 999,
                        child: Icon(
                          PhosphorIcons.pencilSimple(
                              PhosphorIconsStyle.regular),
                          color: Colors.cyan,
                        )),
                    onPressed: () {}),
                shape: const Border(
                  bottom: BorderSide(color: Colors.black26),
                ),
              );
            }));
  }

  Widget _buildSimpleGrid(BuildContext context) {
    return SimpleGrid(
      crossAxisCount: 2,
      children: [
        Container(
          alignment: AlignmentDirectional.center,
          height: 100,
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Text(
            'grid items1',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.teal),
          ),
        ),
        Container(
          alignment: AlignmentDirectional.center,
          height: 100,
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Text(
            'grid items2',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.teal),
          ),
        ),
        Container(
          alignment: AlignmentDirectional.center,
          height: 100,
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Text(
            'grid items2',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
