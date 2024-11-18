import 'package:flutter/material.dart';
import 'package:songtrace/model/playlist_model.dart';
import 'package:songtrace/views/album_view.dart';
// import 'package:spotify_clone_songtrace/views/album_view.dart';

class SongCard extends StatefulWidget {
  final PlaylistData playlistData;
  const SongCard({super.key, required this.playlistData});

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AlbumView(
                      albumData: widget.playlistData,
                    )))
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: 140,
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.playlistData.images[0]),
              height: 140,
              width: 140,
            ),
            Text(
              widget.playlistData.name,
              style: Theme.of(context).textTheme.bodySmall,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
