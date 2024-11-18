import "package:flutter/material.dart";
import "package:songtrace/model/playlist_model.dart";
import "package:songtrace/views/album_view.dart";
import "package:songtrace/views/rpalbum_view.dart";
import "package:songtrace/views/track_view.dart";
// import "package:spotify_clone_songtrace/views/album_view.dart";

class AlbumCard extends StatelessWidget {
  final String image;
  final String label;
  final String searchString;
  const AlbumCard({
    super.key,
    required this.image,
    required this.label,
    required this.searchString,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RPAlbumView(
              albumName: searchString,
              image: image,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/$image',
            width: 120,
            height: 120,
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
