import "package:flutter/material.dart";
// import "package:spotify_clone_songtrace/views/album_view.dart";

class AlbumCard extends StatelessWidget {
  final String image;
  final String label;
  const AlbumCard({
    super.key,
    this.image = "anime.jpg",
    this.label = "none",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AlbumView(
        //       image: AssetImage("assets/$image"),
        //     ),
        //   ),
        // );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/$image",
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
