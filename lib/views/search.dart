// search_view.dart
import 'package:flutter/material.dart';
import 'package:songtrace/helpers/STColors.dart';
import 'package:songtrace/helpers/spotify_api.dart';
import 'package:songtrace/model/playlist_model.dart';
import 'package:songtrace/widgets/SongListCard.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _textController = TextEditingController();
  Future<List<PlaylistData>>? _searchResults;
  bool _isLoading = false;

  void searchFunction() {
    SpotifyService.create();
    setState(() {
      _isLoading = true;
      _searchResults =
          SpotifyService.searchTrackInfoByName(_textController.text);
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
        padding: EdgeInsets.all(16.0),
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
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
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
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No results found"));
                    }

                    List<PlaylistData> playlists = snapshot.data!;
                    print(playlists[0].name);
                    return ListView.builder(
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        var playlist = playlists[index];
                        return SongListCard(playlistData: playlist, mq: mq);
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
