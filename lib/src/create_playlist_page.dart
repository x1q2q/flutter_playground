import 'package:flutter/material.dart';

class CreatePlaylistPage extends StatefulWidget {
  const CreatePlaylistPage({super.key});

  @override
  State<CreatePlaylistPage> createState() => _CreatePlaylistPageState();
}

class _CreatePlaylistPageState extends State<CreatePlaylistPage> {
  @override
  Widget build(BuildContext context) {
    List<String> assetsString = [
      "ant.jpg",
      "building.jpg",
      "lumba.jpg",
      "macan.jpg",
      "village.jpg"
    ];
    List<Widget> listImages =
        assetsString.map((el) => Image.asset("assets/images/$el")).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel Widget'),
      ),
      body: SafeArea(
        child: Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 180),
                child: CarouselView(
                    itemExtent: 320,
                    shrinkExtent: 180,
                    itemSnapping: true,
                    children: listImages))),
      ),
    );
  }
}
