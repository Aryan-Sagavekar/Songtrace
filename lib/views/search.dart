// search_view.dart
import 'package:flutter/material.dart';
import 'package:songtrace/helpers/STColors.dart';
import 'package:songtrace/helpers/spotify_api.dart';
import 'package:songtrace/model/playlist_model.dart';
import 'package:songtrace/widgets/SongListCard.dart';
import 'package:spotify/spotify.dart' as spotify;

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _textController = TextEditingController();
  Future<List<spotify.Track>>? _searchResults;
  bool _isLoading = false;

  void searchFunction() {
    SpotifyService.create();
    setState(() {
      _isLoading = true;
      _searchResults =
          SpotifyService.searchTrackInfoByName(_textController.text, 5);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [STColors.darkBlue, Colors.black],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _textController,
                style: TextStyle(color: STColors.brightOrange),
                cursorColor: STColors.brightOrange,
                decoration: InputDecoration(
                  hintText: 'What\'s the vibe',
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: searchFunction,
                  child: Text(
                    "Search",
                    style: TextStyle(color: STColors.brightOrange),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: mq.size.height * 0.7,
                width: mq.size.width,
                child: FutureBuilder(
                  future: _searchResults,
                  builder: (context, snapshot) {
                    _isLoading = false;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: oops not found"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
