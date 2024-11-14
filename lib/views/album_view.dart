import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart' as spotify;

class AlbumView extends StatefulWidget {
  final spotify.Track trackData;
  const AlbumView({super.key, required this.trackData});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late ScrollController scrollController;
  double imageSize = 0;
  double initialSize = 240;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSongPreview() async {
    final previewUrl = widget.trackData.previewUrl;
    print("clicked play");

    if (previewUrl != null) {
      await _audioPlayer.setUrl(previewUrl);
      _audioPlayer.play();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No preview available for this track')),
      );
    }
  }

  @override
  void initState() {
    imageSize = initialSize;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialSize - scrollController.offset;
        if (imageSize > 0 && imageSize < initialSize) {
          setState(() {});
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.pink,
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.none,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(0, 20),
                              blurRadius: 32,
                              spreadRadius: 16,
                            )
                          ]),
                          child: Image(
                            image: const AssetImage('assets/yoasobi.jpeg'),
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Album picked up for your own good",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SizedBox(height: 16),
                              const Row(
                                children: [
                                  Image(
                                    image:
                                        AssetImage("assets/spotify_logo.png"),
                                    width: 32,
                                    height: 32,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Spotify")
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "1,888,132 likes 5h 3m",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 16),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.favorite),
                                      SizedBox(width: 16),
                                      Icon(Icons.more_horiz),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          width: 64,
                                          height: 64,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.play_arrow,
                                              size: 38,
                                            ),
                                            onPressed: _playSongPreview,
                                          ),
                                        ),
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: const Icon(
                                            Icons.shuffle,
                                            color: Colors.black,
                                            size: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 500,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
