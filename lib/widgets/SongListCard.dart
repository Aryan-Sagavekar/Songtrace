import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:songtrace/helpers/STColors.dart';
import 'package:songtrace/model/playlist_model.dart';

class SongListCard extends StatefulWidget {
  final PlaylistData playlistData;
  final MediaQueryData mq;

  const SongListCard({super.key, required this.playlistData, required this.mq});

  @override
  State<SongListCard> createState() => _SongListCardState();
}

class _SongListCardState extends State<SongListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            image: NetworkImage(widget.playlistData.images[0]),
            width: 70,
            height: 70,
          ),
          Center(child: Text(widget.playlistData.name)),
        ],
      ),
    );
  }
}
