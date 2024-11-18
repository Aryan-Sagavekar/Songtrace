import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:songtrace/helpers/spotify_api.dart';
import 'package:songtrace/model/playlist_model.dart';
import 'package:songtrace/views/track_view.dart';
import 'package:spotify/spotify.dart' as spotify;

class SongCardTrack extends StatefulWidget {
  final spotify.Track trackData;
  const SongCardTrack({super.key, required this.trackData});

  @override
  State<SongCardTrack> createState() => _SongCardTrackState();
}

class _SongCardTrackState extends State<SongCardTrack> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TrackView(
                  trackData: widget.trackData,
                )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: 140,
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                  widget.trackData.album!.images![0].url.toString()),
              height: 140,
              width: 140,
            ),
            Text(
              widget.trackData.name.toString(),
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
