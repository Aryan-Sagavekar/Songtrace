import 'package:flutter/material.dart';
import 'package:songtrace/helpers/spotify_api.dart';
import 'package:songtrace/model/playlist_model.dart';
import 'package:songtrace/widgets/AlbumCard.dart';
import 'package:songtrace/widgets/SongCard.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<PlaylistData>>? _youMightLikeSongs;

  @override
  void initState() {
    super.initState();
    _youMightLikeSongs = SpotifyService.fetchFeaturedPlaylists();
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
                          AlbumCard(label: "Beast Mode", image: "anime.jpg"),
                          SizedBox(width: 16),
                          AlbumCard(label: "Peace", image: "kishore.jpeg"),
                          SizedBox(width: 16),
                          AlbumCard(label: "Melody of lata", image: "lata.jpg"),
                          SizedBox(width: 16),
                          AlbumCard(label: "Ophelia", image: "ophelia.jpeg"),
                          SizedBox(width: 16),
                          AlbumCard(
                              label: "Japnaese hits", image: "yoasobi.jpeg"),
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
                            "What you might like",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        // const SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   physics: BouncingScrollPhysics(),
                        //   padding: EdgeInsets.symmetric(horizontal: 12),
                        //   child: Row(
                        //     children: [
                        //       SongCard(
                        //         image: AssetImage("assets/yoasobi.jpeg"),
                        //         label: "Yoasobi, Tyler, Joseph and many more",
                        //       ),
                        //       SizedBox(width: 16),
                        //       SongCard(
                        //         image: AssetImage("assets/ghost.jpeg"),
                        //         label: "INTERWORLD, Kyler, HIT and many more",
                        //       ),
                        //       SizedBox(width: 16),
                        //       SongCard(
                        //         image: AssetImage("assets/lata.jpg"),
                        //         label:
                        //             "Kishore Kumar, Lata Mangeshkar and many more",
                        //       ),
                        //       SizedBox(width: 16),
                        //     ],
                        //   ),
                        // ),

                        SizedBox(
                          child: FutureBuilder(
                            future: _youMightLikeSongs,
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
                                return const Center(
                                    child: Text("No results found"));
                              }

                              List<PlaylistData> playlists = snapshot.data!;
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var playlist = playlists[index];
                                    return SongCard(
                                        image:
                                            AssetImage('assets/yoasobi.jpeg'),
                                        label: playlist.name);
                                  });
                            },
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
                            "Recommended Radio",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              SongCard(
                                image: AssetImage("assets/yoasobi.jpeg"),
                                label: "Yoasobi, Tyler, Joseph and many more",
                              ),
                              SizedBox(width: 16),
                              SongCard(
                                image: AssetImage("assets/ghost.jpeg"),
                                label: "INTERWORLD, Kyler, HIT and many more",
                              ),
                              SizedBox(width: 16),
                              SongCard(
                                image: AssetImage("assets/lata.jpg"),
                                label:
                                    "Kishore Kumar, Lata Mangeshkar and many more",
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                        ),
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
