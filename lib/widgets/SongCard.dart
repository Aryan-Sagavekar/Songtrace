import 'package:flutter/material.dart';
// import 'package:spotify_clone_songtrace/views/album_view.dart';

class SongCard extends StatelessWidget {
  final AssetImage image;
  final String label;
  const SongCard({super.key, required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => AlbumView(image: image)))
      },
      child: Container(
        width: 140,
        child: Column(
          children: [
            Image(
              image: image,
              height: 140,
              width: 140,
            ),
            Text(
              label,
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
