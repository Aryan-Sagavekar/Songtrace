import 'package:flutter/material.dart';
import 'package:songtrace/helpers/spotify_api.dart';
import 'package:songtrace/model/playlist_model.dart';
import 'package:songtrace/widgets/AlbumCard.dart';
import 'package:songtrace/widgets/SongCardPlaylist.dart';
import 'package:songtrace/widgets/SongCardTrack.dart';
import 'package:spotify/spotify.dart' as spotify;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<PlaylistData>>? _top100Playlists;
  Future<List<spotify.Track>>? _topSongs;

  @override
  void initState() {
    super.initState();
    SpotifyService.create();
    _top100Playlists = SpotifyService.fetchFeaturedPlaylists();
    _topSongs = SpotifyService.fetchTopSongs();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: mq.size.width,
            height: mq.size.height * .6,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 182, 197, 253),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recently Played",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.history),
                              SizedBox(width: 20),
                              Icon(Icons.settings),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          AlbumCard(
                              searchString: "demon slayer",
                              label: "Beast Mode",
                              image: "anime.jpg"),
                          SizedBox(width: 16),
                          AlbumCard(
                              searchString: "Kishore",
                              label: "Peace",
                              image: "kishore.jpeg"),
                          SizedBox(width: 16),
                          AlbumCard(
                              searchString: "lata mangeshkar",
                              label: "Melody of lata",
                              image: "lata.jpg"),
                          SizedBox(width: 16),
                          AlbumCard(
                              searchString: "Ophelia",
                              label: "Ophelia",
                              image: "ophelia.jpeg"),
                          SizedBox(width: 16),
                          AlbumCard(
                              searchString: "yoasobi",
                              label: "Japnaese hits",
                              image: "yoasobi.jpeg"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Good Afternoon",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              RowAlbumCard(
                                image: AssetImage("assets/top50.png"),
                                label: "Top 50 global",
                              ),
                              SizedBox(width: 16),
                              RowAlbumCard(
                                image: AssetImage("assets/ghost.jpeg"),
                                label: "Ghost Phonk",
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              RowAlbumCard(
                                image: AssetImage("assets/phonk.png"),
                                label: "Phonk",
                              ),
                              SizedBox(width: 16),
                              RowAlbumCard(
                                image: AssetImage("assets/science.jpg"),
                                label: "Science",
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              RowAlbumCard(
                                image: AssetImage("assets/dark.jpeg"),
                                label: "Dark",
                              ),
                              SizedBox(width: 16),
                              RowAlbumCard(
                                image: AssetImage("assets/yoasobi.jpeg"),
                                label: "Best of yoasobi",
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Top 100 songs Playlists",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                height: mq.size.height * 0.25,
                                width: mq.size.width,
                                child: FutureBuilder(
                                  future: _top100Playlists,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text("Error: ${snapshot.error}"));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                          child: Text("No results found"));
                                    }

                                    List<PlaylistData> playlists =
                                        snapshot.data!;
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          var playlist = playlists[index];
                                          return SongCard(
                                              playlistData: playlist);
                                        });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Top Songs",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                height: mq.size.height * 0.25,
                                width: mq.size.width,
                                child: FutureBuilder(
                                  future: _topSongs,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text("Error: ${snapshot.error}"));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                          child: Text("No results found"));
                                    }

                                    List<spotify.Track> tracks = snapshot.data!;
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: tracks.length,
                                        itemBuilder: (context, index) {
                                          var track = tracks[index];
                                          return SongCardTrack(
                                              trackData: track);
                                        });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowAlbumCard extends StatelessWidget {
  final AssetImage image;
  final String label;
  const RowAlbumCard({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Image(
              image: image,
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            Text(label)
          ],
        ),
      ),
    );
  }
}
