import 'package:flutter/material.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  final List<Map<String, String>> libraryItems = [
    {'title': 'Best of Lata', 'image': 'assets/lata.jpg'},
    {'title': 'Kishore Kumar', 'image': 'assets/kishore.jpeg'},
    {'title': 'Phonk', 'image': 'assets/ghost.jpeg'},
    {'title': 'Yoasobi', 'image': 'assets/yoasobi.jpeg'},
    {'title': 'Best in Anime', 'image': 'assets/anime.jpg'},
    {'title': 'Dark Days', 'image': 'assets/dark.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.8,
        ),
        itemCount: libraryItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display image from assets
                Expanded(
                  child: Image.asset(
                    libraryItems[index]['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  libraryItems[index]['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
