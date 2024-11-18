import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';
import 'package:songtrace/helpers/spotify_api.dart';
import 'package:songtrace/model/playlist_model.dart';
import 'package:songtrace/widgets/SongListCard.dart';
import 'package:spotify/spotify.dart' as spotify;

class RPAlbumView extends StatefulWidget {
  final String image;
  final String albumName;
  const RPAlbumView({super.key, required this.image, required this.albumName});

  @override
  State<RPAlbumView> createState() => _RPAlbumViewState();
}

class _RPAlbumViewState extends State<RPAlbumView> {
  late ScrollController scrollController;
  double imageSize = 0;
  double initialSize = 240;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Future<List<spotify.Track>>? _tracksFromSpecificAlbum;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // void _playAlbumTracksPreview() async {
  //   final previewUrl = widget.albumData.previewUrl;
  //   print("clicked play");

  //   if (previewUrl != null) {
  //     await _audioPlayer.setUrl(previewUrl);
  //     _audioPlayer.play();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('No preview available for this track')),
  //     );
  //   }
  // }

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

    _tracksFromSpecificAlbum =
        SpotifyService.searchTrackInfoByName(widget.albumName, 10);
    // print(widget.albumData.tracksData.href);
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.pink,
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
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
                              offset: const Offset(0, 20),
                              blurRadius: 32,
                              spreadRadius: 16,
                            )
                          ]),
                          child: Image(
                            image: AssetImage('assets/${widget.image}'),
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Album picked up for your own good",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 16),
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
                                "10 Songs, Picked for you",
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
                                            onPressed: () {},
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
                    width: mq.size.width,
                    child: FutureBuilder(
                      future: _tracksFromSpecificAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text("No results found"));
                        }

                        List<spotify.Track> tracks = snapshot.data!;
                        return ListView.builder(
                          itemCount: tracks.length,
                          itemBuilder: (context, index) {
                            var track = tracks[index];
                            return SongListCard(trackData: track, mq: mq);
                          },
                        );
                      },
                    ),
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
