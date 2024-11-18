import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:songtrace/helpers/STColors.dart';
import 'package:songtrace/views/track_view.dart';
import 'package:spotify/spotify.dart' as spotify;

class SongListCard extends StatefulWidget {
  final spotify.Track trackData;
  final MediaQueryData mq;

  const SongListCard({super.key, required this.trackData, required this.mq});

  @override
  State<SongListCard> createState() => _SongListCardState();
}

class _SongListCardState extends State<SongListCard> {
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
        decoration: BoxDecoration(
          color: STColors.navyBlue,
          border: const Border(),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  widget.trackData.album!.images![0].url.toString()),
              width: 70,
              height: 70,
            ),
            Center(child: Text(widget.trackData.name.toString())),
          ],
        ),
      ),
    );
  }
}
